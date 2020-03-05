const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی فاکتور اجباری است.').isInt({min: 0}).withMessage('آیدی فاکتور نا معتبر است.'),
];

const materialIdChecker = [
    check('materials').exists().isArray().withMessage('لیست مواد اولیه اجباری است').custom( value => { return value.length > 0}).withMessage('لیست مواد اولیه خالی است.'),
    check('materials[*].material_data_id').exists().withMessage('آیدی مواد اولیه اجباری است.').isInt({min: 0}).withMessage('آیدی مواد اولیه نا معتبر است.'),
    check('materials[*].amount').exists().withMessage('مقدار مواد اولیه اجباری است.').isInt({min: 1}).withMessage('مقدار مواد اولیه نا معتبر است.'),
];

const supplierIdChecker = [
    check('supplier_id').exists().withMessage('آیدی شرکت اجباری است.').isInt({min : 0}).withMessage('آیدی شرکت نا معتبر است.')
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

router.get("/", async (req,res) => {
    let [result] = await promisePool.query("SELECT * FROM supplier_order");
    res.status(200).send(result);
});

router.get('/:id',idValidator, handleErrorRejection, async (req,res) => {
    let order = ( await promisePool.query("SELECT * FROM supplier_order WHERE id = ?",[req.params.id]) )[0][0];
    res.status(200).json(order);
});

router.get('/:id/materials', idValidator, handleErrorRejection , async (req,res) => {
    let [result] = await promisePool.query("SELECT material_name,amount,price,(amount * price) as total_price,material_data_history.id as material_data_id FROM supplier_order_items join supplier_order on supplier_order_items.supplier_order_id = supplier_order.id JOIN material_data_history on supplier_order_items.material_data_id = material_data_history.id WHERE supplier_order.id = ?",[req.params.id])
    res.status(200).send(result);
});

router.get('/:id/supplier' , idValidator, handleErrorRejection, async(req,res) => {
    let [result] = await promisePool.query("SELECT supplier.* FROM supplier_order JOIN supplier on supplier_order.supplier_id = supplier.id WHERE supplier_order.id = ?",[req.params.id]);
    res.status(200).send(result[0]);
});


router.post('/',materialIdChecker,supplierIdChecker, handleErrorRejection, async(req,res) => {
    try {
        let [result] = await promisePool.query("INSERT INTO supplier_order(supplier_id) VALUES(?)",[req.body.supplier_id]);
        for(let material of req.body.materials) {
            await promisePool.query("INSERT INTO supplier_order_items(supplier_order_id,material_data_id,amount) VALUES(?,?,?)",[result.insertId,material.material_data_id,material.amount]);
        }
        res.status(201).send(result);
    } catch (e) {
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

router.delete('/:id', idValidator, handleErrorRejection , async (req,res) => {
    let [result] = await promisePool.query("DELETE FROM supplier_order WHERE id = ?",[req.params.id]);
    res.status(204).send(result);
});



module.exports = router;