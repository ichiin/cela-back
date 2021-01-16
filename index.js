const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const jsonParser = bodyParser.json()
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))
// parse application/json
app.use(bodyParser.json())
const { check, validationResult } = require('express-validator');

const port = 3001

let mysql      = require('mysql');
let connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database: 'cela'
});
let cors = require('cors');
app.use(cors());
connection.connect();

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})

app.get('/getSubjectList', function (req, res) {
    connection.query('SELECT * from subject', function(err, rows, fields) {
        if (err){
            console.log("wat")
            throw err;
        }else {
            res.header("Access-Control-Allow-Origin", "*")
            res.send(rows)
        }
    });
});

app.post('/getUser', jsonParser, function (req, res) {
    connection.query('SELECT * from student WHERE email = ?', [req.body.Email], function(err, rows, fields) {
        if (err){
            throw err;
        } else {
            res.header("Access-Control-Allow-Origin", "*")
            res.send(rows)
        }
    });
});

app.post('/reg', [
    check('Email').isEmail().withMessage('Invalid form!'),
    check('Email')
        .exists()
        .isLength({ min: 6, max: 100 })
        .isEmail()
        .normalizeEmail()
        .trim()
        .custom(async Email => { 
            const value = await isEmailInUse(Email);
            if (value) {
                throw new Error('Already registered!');
            }
        })
        .withMessage('Invalid email address!!!'),
    check('RepeatedPassword')
        .trim()
        .custom(async (RepeatedPassword, {req}) => { 
            const password = JSON.stringify(req.body.Password)
            // If password and confirm password not same 
            // don't allow to sign up and throw error 
            if(password !== JSON.stringify(RepeatedPassword)){ 
              throw new Error('Passwords must be same') 
            } 
          }), 
  ], (req, res) => {
    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      return res.status(422).json({ errors: errors.array() })
    }
    var email = req.body.Email
    var password = req.body.Password

    connection.query("INSERT INTO `student`(`email`,`password`) VALUES(?,?)",[email, password], function(err, rows, fields) {
        if (err){
            console.log("wat")
            throw err;
        } else {
            console.log("sending reqs")
            res.header("Access-Control-Allow-Origin", "*")
            res.send(rows)
        }
    });
  })

  function isEmailInUse(Email){
    return new Promise((resolve, reject) => {
        connection.query('SELECT COUNT(*) AS total FROM student WHERE email = ?', [Email], function (error, results, fields) {
            if(!error){
                console.log("EMAIL COUNT : "+results[0].total);
                return resolve(results[0].total > 0);
            } else {
                return reject(new Error('Database error!!'));
            }
          }
        );
    });
}