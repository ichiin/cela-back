const express = require('express')
const app = express()
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

app.get('/', (req, res) => {
    res.send('Hello World!')
})

app.get('/getSubjectList', function (req, res) {
    console.log("OK WE IN")
    connection.query('SELECT * from subject', function(err, rows, fields) {
        if (err){
            console.log("wat")
            throw err;
        }else {
            console.log("sending reqs")
            res.header("Access-Control-Allow-Origin", "*")
            res.send(rows)
        }
    });
});

