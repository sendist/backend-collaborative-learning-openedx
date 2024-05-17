import mysql from 'mysql2/promise';

export default mysql.createPool({
    user: "root",
    password: "2eEG4259",
    host: "194.233.93.124",
    port: 6969,
    database: "openedx",
})