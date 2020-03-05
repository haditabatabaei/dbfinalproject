const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const validator = require('validator');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی فاکتور اجباری است.').isInt({min: 0}).withMessage('آیدی فاکتور نا معتبر است.'),
];

const addrIdValidator = [
    check('addrId').exists().withMessage('آیدی آدرس اجباری است.').isInt({min: 0}).withMessage('آیدی آدرس نا معتبر است.'),
];

const customerIdValidator = [
    check('customerId').exists().withMessage('آیدی کاربر اجباری است.').isInt({min: 0}).withMessage('آیدی کاربر نا معتبر است.'),
];
const courierIdValidator = [
    check('courierId').exists().withMessage('آیدی پیک اجباری است.').isInt({min: 0}).withMessage('آیدی پیک نا معتبر است.'),
];

const statusValidator = [
    check('status').exists().withMessage('مشخص بودن وضعیت اجباری است.').isIn(["notdelivered","delivered"]).withMessage("وضعیت باید یکی از مقادیر معتبر باشد.")
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get('/customer', async (req,res) => {
	let [result] = await promisePool.query("SELECT * FROM customer_log");
	res.status(200).send(result);
});

router.get('/address', async (req,res) => {
	let [result] = await promisePool.query("SELECT * FROM address_log");
	res.status(200).send(result);
});

router.get('/supplier', async (req,res) => {
	let [result] = await promisePool.query("SELECT * FROM supplier_log");
	res.status(200).send(result);
});

router.get('/courier', async (req,res) => {
	let [result] = await promisePool.query("SELECT * FROM courier_log");
	res.status(200).send(result);
});

router.post('/foods/table', async(req,res) => {
	let resu = await promisePool.query("CREATE TABLE food" + 
	"(id bigint(20) UNSIGNED NOT NULL," +
	"name varchar(50) COLLATE utf8_persian_ci NOT NULL" +
	") ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_persian_ci;");
	res.status(201).send(resu);
})

router.delete('/foods/table', async(req,res) => {
	let resu = await promisePool.query("DROP TABLE food")
	res.status(204).send(resu);
})

module.exports = router;