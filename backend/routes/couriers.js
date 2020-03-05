const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی پیک اجباری است.').isInt({min: 0}).withMessage('آیدی پیک نا معتبر است.')
];

const courierValidation = [
    check('first_name').exists().withMessage('نام اجباری است.').isLength({min : 1, max : 50}).withMessage('نام اجباری است.'),
    check('last_name').exists().withMessage('نام خانوادگی اجباری است').isLength({min : 1, max : 50}).withMessage('نام خانوادگی اجباری است.'),
    check('phone_number').exists().withMessage('شماره تماس اجباری است.').matches("(\\+98|0|98|0098)?([ ]|-|[()]){0,2}9[0-9]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}").withMessage('شماره تماس معتبر نمیباشد'),
    check('identification_number').exists().withMessage('کد ملی اجباری است.').isNumeric().withMessage('کد ملی فقط شامل عدد است.').isLength({
        min: 4,
        max: 10
    }).withMessage('کد ملی باید بین 4 و 10 کاراکتر باشد'),
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get('/', async (req, res) => {
    let [couriers] = await promisePool.query("SELECT * FROM courier");
    res.status(200).send(couriers);
});

router.get('/available', async (req, res) => {
	let [couriers] = await promisePool.query("SELECT DISTINCT courier.* FROM courier WHERE courier.id NOT IN (SELECT courier_id FROM courier_on_order WHERE status = 'notdelivered')");
	res.status(200).send(couriers);
});

router.post('/', courierValidation, handleErrorRejection, async (req, res) => {
    let [courierResult] = await promisePool.query("INSERT INTO courier(first_name,last_name,identification_number,phone_number) VALUES(?,?,?,?)", [req.body.first_name, req.body.last_name, req.body.identification_number, req.body.phone_number]);
    req.body.id = courierResult.insertId;
    res.status(201).json(req.body);
});

router.get('/:id', idValidator, handleErrorRejection, async (req, res) => {
    let [courier] = await promisePool.query("SELECT * FROM courier WHERE id = ?", [req.params.id]);
    res.status(200).send(courier[0]);
});

router.delete('/:id', idValidator, handleErrorRejection , async(req,res) => {
    let [deleteResult] = await promisePool.query("DELETE FROM courier WHERE id = ?",[req.params.id]);
    res.status(200).send(deleteResult);
});

router.patch('/:id',idValidator, courierValidation,handleErrorRejection, async (req,res) => {
    let [updatedResult] = await promisePool.query("UPDATE courier SET first_name = ?,last_name = ?,identification_number =?,phone_number = ? WHERE id = ?",[req.body.first_name, req.body.last_name, req.body.identification_number, req.body.phone_number,req.params.id])
    res.status(200).send(updatedResult);
});

module.exports = router;