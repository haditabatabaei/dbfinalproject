const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');


const idValidator = [
    check('id').exists().withMessage('آیدی آدرس اجباری است.').isInt({min: 0}).withMessage('آیدی آدرس نا معتبر است.'),
];

const addrValidation = [
    check('name').optional().isLength({min : 1}).withMessage('نام اجباری است.'),
    check('text').exists().withMessage('متن آدرس اجباری است'),
    check('static_phone').exists().withMessage('شماره تلفن اجباری است.').matches('[0]\\d{2,3}\\d{8}').withMessage('شماره تلفن معتبر نمیباشد'),
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get('/', async (req,res) => {
    res.status(200).send((await promisePool.query("SELECT * FROM address"))[0]);
});

router.post('/', addrValidation, handleErrorRejection, async (req,res) => {
    let [result] = await promisePool.query("INSERT INTO address(name,text,static_phone) VALUES(?,?,?)",[req.body.name,req.body.text,req.body.static_phone]);
	let [addedAddress] = await promisePool.query("SELECT * FROM address WHERE id = ?",[result.insertId]);
    res.status(201).send(addedAddress[0]);
});

router.patch('/:id',idValidator,addrValidation, handleErrorRejection , async (req,res) => {
    let [updateResult] = await promisePool.query("UPDATE address SET name = ?,text = ?,static_phone = ? WHERE id = ?",[req.body.name,req.body.text,req.body.static_phone, req.params.id]);
    res.status(200).send(updateResult);
});


module.exports = router;