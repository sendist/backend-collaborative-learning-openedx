import mysql from 'mysql2/promise';

export default mysql.createPool({
    user: "root",
    password: "0BQ6P4Wv",
    host: "194.233.93.124",
    port: 6969,
    database: "openedx",
})