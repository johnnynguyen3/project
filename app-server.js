const express = require("express");
const  { Pool } = require('pg');
const path = require("path");
const app = express();
const PORT = 3000;

let router = require('./router/app-router');

require('dotenv').config({
    override: true,
    path: path.join(__dirname, 'db.env')
});

/* Initialization of pool connection to PostgreSQL database */
const pool = new Pool({
    user: process.env.USER,
    host: process.env.HOST,
    database: process.env.DATABASE,
    password: process.env.PASSWORD,
    post: process.env.PORT,
})

app.locals.db;


/* Setup Middleware */
app.use(express.urlencoded({extended:true}));
app.use(express.json());

/* Server Routes */
app.use("/", router);


app.listen(PORT, () => {
    app.locals.db = pool;
    console.log(`Health & Fitness Management Server Application Running at http://127.0.0.1:${PORT}`);
})
