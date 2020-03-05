const express = require('express');
const router = express.Router();
const {promisePool} = require('./../Config.js');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی کاربر اجباری است.').isInt({min: 0}).withMessage('آیدی کاربر نا معتبر است.'),
];

const addrIdValidator = [
    check('addrId').exists().withMessage('آیدی آدرس اجباری است.').isInt({min: 0}).withMessage('آیدی آدرس نا معتبر است.')
];

const userValidation = [
    check('first_name').exists().withMessage('نام اجباری است.').isLength({min : 1, max: 50}).withMessage('نام اجباری است.'),
    check('last_name').exists().withMessage('نام خانوادگی اجباری است').isLength({min : 1, max: 50}).withMessage('نام خانوادگی اجباری است.'),
    check('phone_number').exists().withMessage('شماره تماس اجباری است.').matches("(\\+98|0|98|0098)?([ ]|-|[()]){0,2}9[0-9]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}").withMessage('شماره تماس معتبر نمیباشد'),
    check('identification_number').exists().withMessage('کد ملی اجباری است.').isNumeric().withMessage('کد ملی فقط شامل عدد است.').isLength({
        min: 4,
        max: 10
    }).withMessage('کد ملی باید بین 4 و 10 کاراکتر باشد'),
    check('age').optional().isInt({min: 15, max: 100}).withMessage('سن باید بین 15 تا 100 باشد')
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get('/', async (req, res) => {
    let [users] = await promisePool.query("SELECT * FROM customer");
    res.status(200).send(users);
});

router.post('/', userValidation, handleErrorRejection, async (req, res) => {
    let [userResult] = await promisePool.query("INSERT INTO customer(first_name,last_name,identification_number,phone_number,age) VALUES(?,?,?,?,?)", [req.body.first_name, req.body.last_name, req.body.identification_number, req.body.phone_number, req.body.age]);
    req.body.id = userResult.insertId;
    res.status(201).json(req.body);
});

router.get('/:id', idValidator, handleErrorRejection, async (req, res) => {
    let [user] = await promisePool.query("SELECT * FROM customer WHERE id = ?", [req.params.id]);
    res.status(200).send(user[0]);
});

router.delete('/:id', idValidator, handleErrorRejection, async (req, res) => {
    try {
        let [deleteResult] = await promisePool.query("DELETE FROM customer WHERE id = ?", [req.params.id]);
        res.status(200).send(deleteResult);
    } catch (e) {
        res.status(500).send({
            errors: [
                {
                    "msg": e.sqlMessage,
                    "location": "sqlserver"
                }
            ]
        })
    }

});

router.patch('/:id', idValidator, userValidation, handleErrorRejection, async (req, res) => {
    let [updatedResult] = await promisePool.query("UPDATE customer SET first_name = ?,last_name = ?,identification_number =?,phone_number = ?,age =? WHERE id = ?", [req.body.first_name, req.body.last_name, req.body.identification_number, req.body.phone_number, req.body.age, req.params.id])
    res.status(200).send(updatedResult);
});

router.get('/:id/addresses', idValidator, handleErrorRejection, async (req, res) => {
    let [result] = await promisePool.query("SELECT address.* FROM customer join customer_address on customer.id = customer_address.customer_id join address on customer_address.address_id = address.id WHERE customer.id = ?", [req.params.id]);
    res.status(200).send(result);
});

router.put('/:id/addresses/:addrId', idValidator, addrIdValidator, handleErrorRejection, async (req, res) => {
    try {
        let [putResult] = await promisePool.query("INSERT INTO customer_address VALUES(?,?)", [req.params.id, req.params.addrId]);
        res.status(200).send(putResult);
    } catch (e) {
        res.status(500).send({
            errors: [
                {
                    "msg": e.sqlMessage,
                    "location": "sqlserver"
                }
            ]
        });
    }
});

router.delete("/:id/addresses/:addrId", idValidator, addrIdValidator, handleErrorRejection, async (req, res) => {
    try {
        let [deleteResult] = await promisePool.query("DELETE FROM customer_address WHERE customer_id = ? and address_id = ?", [req.params.id, req.params.addrId]);
        res.status(200).send(deleteResult);
    } catch (e) {
        res.status(500).send({
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