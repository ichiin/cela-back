const moment = require("moment");

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const jsonParser = bodyParser.json();
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
// parse application/json
app.use(bodyParser.json());
const { check, validationResult } = require("express-validator");

const port = 3001;

let mysql = require("mysql");
let connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "cela",
});
let cors = require("cors");
app.use(cors());
connection.connect();

app.listen(port, () => {
  console.log(`Server listening at http://localhost:${port}`);
});

app.get("/getSubjectList", function (req, res) {
  connection.query("SELECT * from subject", function (err, rows, fields) {
    if (err) {
      throw err;
    } else {
      res.header("Access-Control-Allow-Origin", "*");
      res.send(rows);
    }
  });
});

app.post("/getUser", jsonParser, function (req, res) {
  connection.query(
    "SELECT * from student WHERE email = ?",
    [req.body.Email],
    function (err, rows, fields) {
      if (err) {
        throw err;
      } else {
        res.header("Access-Control-Allow-Origin", "*");
        res.send(rows);
      }
    }
  );
});

app.post(
  "/reg",
  [
    check("Email").isEmail().withMessage("Invalid form!"),
    check("Email")
      .exists()
      .isLength({ min: 6, max: 100 })
      .isEmail()
      .normalizeEmail()
      .trim()
      .custom(async (Email) => {
        const value = await isEmailInUse(Email);
        if (value) {
          throw new Error("Already registered!");
        }
      })
      .withMessage("Invalid email address!!!"),
    check("RepeatedPassword")
      .trim()
      .custom(async (RepeatedPassword, { req }) => {
        const password = JSON.stringify(req.body.Password);
        // If password and confirm password not same
        // don't allow to sign up and throw error
        if (password !== JSON.stringify(RepeatedPassword)) {
          throw new Error("Passwords must be same");
        }
      }),
  ],
  (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(422).json({ errors: errors.array() });
    }
    var email = req.body.Email;
    var password = req.body.Password;

    connection.query(
      "INSERT INTO `student`(`email`,`password`) VALUES(?,?)",
      [email, password],
      function (err, rows, fields) {
        if (err) {
          throw err;
        } else {
          res.header("Access-Control-Allow-Origin", "*");
          res.send(rows);
        }
      }
    );
  }
);

app.post("/setUserInformation", jsonParser, (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(422).json({ errors: errors.array() });
  }
  let email = req.body.email || "NULL";
  let lastName = req.body.lastName || "NULL";
  let firstName = req.body.firstName || "NULL";
  let birthDate =
    moment(new Date(req.body.birthDate)).format("YYYY-MM-DD") || new Date();
  let nationality = req.body.nationality || "NULL";
  let sex = req.body.sex || "NULL";
  let fieldOfEducation = parseInt(req.body.fieldOfEducation) || 1;
  let sending_institutionName = req.body.sending_institutionName || "NULL";
  let sending_faculty = req.body.sending_faculty || NULL;
  let sending_erasmusCode = req.body.sending_erasmusCode || "NULL";
  let sending_address = req.body.sending_address || "NULL";
  let sending_country = req.body.sending_country || "NULL";
  let sending_contact_name = req.body.sending_contact_name || "NULL";
  let sending_contact_mail = req.body.sending_contact_mail || "NULL";
  //let receiving_faculty = "NULL";
  let receiving_contact_name = req.body.receiving_contact_name || "NULL";
  let receiving_contact_mail = req.body.receiving_contact_mail || "NULL";

  connection.query(
    "UPDATE `student` SET `last_name` = ?,`first_name` = ?,`birth_date` =  ?,`nationality` =  ?,`sex` =  ?,`field_of_education` =  ?,`sending_inst_name` =  ?,`sending_inst_dept` =  ?,`sending_inst_erascode` =  ?,`sending_inst_address` =  ?,`sending_inst_country` =  ?,`sending_inst_contact_name` =  ?,`sending_inst_contact_email` =  ?,`receiving_inst_contact_name` =  ?,`receiving_inst_contact_name` =  ? WHERE student.email = ?",
    [
      lastName,
      firstName,
      birthDate,
      nationality,
      sex,
      fieldOfEducation,
      sending_institutionName,
      sending_faculty,
      sending_erasmusCode,
      sending_address,
      sending_country,
      sending_contact_name,
      sending_contact_mail,
      receiving_contact_name,
      receiving_contact_mail,
      email,
    ],
    function (err, rows, fields) {
      if (err) {
        throw err;
      } else {
        res.header("Access-Control-Allow-Origin", "*");
        res.send(rows);
      }
    }
  );
});

app.post("/getUserInformation", function (req, res) {
  let email = req.body.email;
  connection.query(
    "SELECT * from student WHERE email = ?",
    [email],
    function (err, rows, fields) {
      if (err) {
        throw err;
      } else {
        res.header("Access-Control-Allow-Origin", "*");
        res.send(rows);
      }
    }
  );
});

function isEmailInUse(Email) {
  return new Promise((resolve, reject) => {
    connection.query(
      "SELECT COUNT(*) AS total FROM student WHERE email = ?",
      [Email],
      function (error, results, fields) {
        if (!error) {
          return resolve(results[0].total > 0);
        } else {
          return reject(new Error("Database error!!"));
        }
      }
    );
  });
}
