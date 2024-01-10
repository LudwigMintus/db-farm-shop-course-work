const Pool = require('pg').Pool
const pool = new Pool ({
    host: 'localhost', // Connect to the local port forwarded by SSH tunnel
    database: 'studs',
    port: 5436, // Local port forwarded by SSH tunnel
    user: '',
    password:''
    })
module.exports = pool