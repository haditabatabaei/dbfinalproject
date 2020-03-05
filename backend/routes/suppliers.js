const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');


const idValidator = [
    check('id').exists().withMessage('آیدی شرکت اجباری است.').isInt({min: 0}).withMessage('آیدی شرکت نا معتبر است.'),
];

const supplierPostValidator = [
    check('title').exists().withMessage('نام شرکت اجباری است.').isLength({min : 1, max: 50}).withMessage('نام شرکت اجباری است.'),
    check('is_available').exists().withMessage('وضعیت شرکت اجباری است').isBoolean().withMessage('وضعیت شرکت باید یک مقداری منطقی فعال یا غیر فعال باشد.')
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get('/', async (req,res) => {
    let [result] = await promisePool.query("SELECT * FROM supplier");
    res.status(200).send(result);
});

router.get('/:id', idValidator,handleErrorRejection, async(req,res) => {
   let [result] = await promisePool.query("SELECT * FROM supplier WHERE id = ?",[req.params.id]);
   res.status(200).send(result[0]);
});

router.patch('/:id',idValidator,supplierPostValidator,handleErrorRejection, async (req,res) => {
    let [updateResult] = await promisePool.query("UPDATE supplier SET title = ?,is_available = ? WHERE id = ? ",[req.body.title,req.body.is_available,req.params.id]);
    res.status(200).send(updateResult);
});

router.post('/',supplierPostValidator, handleErrorRejection, async(req,res) => {
    let [insertResult] = await promisePool.query("INSERT INTO supplier(title,is_available) VALUES(?,?)",[req.body.title,req.body.is_available]);
    let [currentAdded] = await promisePool.query("SELECT * FROM supplier WHERE id = ?",[insertResult.insertId]);
    res.status(201).send(currentAdded[0]);
});

router.delete('/:id', idValidator, handleErrorRejection, async(req,res) => {
    try {
        let [result] = await promisePool.query("DELETE FROM supplier WHERE id = ?",[req.params.id]);
        res.status(200).send(result);
    } catch(e) {
        res.status(400).send({
            errors: [
                {
                    "msg" : e.sqlMessage,
                    "location" : "sqlserver"
                }
            ]
        })
    }
});

module.exports = router;