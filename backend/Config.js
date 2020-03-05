const mysql = require('mysql2');
const config = {
    host: 'localhost',
    port: 3306,
    user: 'root',
    database: 'sita2'
};

const sqlPool = mysql.createPool(config);
const promisePool = sqlPool.promise();

module.exports = {
    promisePool
};