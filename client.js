var pgtools = require("pgtools");
const config = {
    user: "postgres",
    host: "localhost",
    password: "postgres",
    port: 5432
};
pgtools.createdb(config, "turf_portal", function(err, res) {
    if (err) {
        console.error(err);
        process.exit(-1);
    }
    console.log(res);
});

// pgclient.query(text, values, (err, res) => {
//     if (err) throw err
// });

// pgclient.query('SELECT * FROM student', (err, res) => {
//     if (err) throw err
//     console.log(err, res.rows) // Print the data in student table
//     pgclient.end()
// });
