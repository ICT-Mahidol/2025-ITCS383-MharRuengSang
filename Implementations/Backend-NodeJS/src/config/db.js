require('dotenv').config();
const mysql = require('mysql2/promise');

// Create the connection pool
const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'mharruengsang',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  typeCast: function (field, next) {
    if (field.type === 'TINY' && field.length === 1) {
      return (field.string() === '1'); // 1 = true, 0 = false
    }
    if (field.type === 'DECIMAL' || field.type === 'NEWDECIMAL') {
      return parseFloat(field.string()); // convert decimal to Number instead of String
    }
    return next();
  }
});

module.exports = pool;