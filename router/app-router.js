const express = require('express');
const router = express.Router();

router.get("/", getAllMembers);
router.get("/updateprofile/:id",[parseQuery],setProfile)

function parseQuery(req,res,next) {
    console.log(req.params);
    next();
}

async function getAllMembers(req,res) {
    let pool = req.app.locals.db;
    try {
        let results = await pool.query('SELECT * FROM Member');

        res.status(200).send(results.rows);
    } catch (err){
        console.error(err);
    }
}

async function getAllStaffMembers(req,res){
    let pool = req.app.locals.db;
    try{
        let results = await pool.query('SELECT * FROM ClubStaff');

        res.status(200).send(results.rows);
    } catch (err){
        console.error(err);
    }
}

async function setProfile(req,res) {
    let pool = req.app.locals.db;
    try {
        let newAddy = 'LeBronto, Ontario, Canada';
        let memberID = parseInt(req.params.id);
        let results = await pool.query('UPDATE member SET address = $1 WHERE memberid = $2 RETURNING *',[newAddy,memberID])
        res.status(200).send(results.rows[0]);
    } catch (err){
        console.error(err);
    }

}

module.exports = router;