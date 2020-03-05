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

const foodValidator = [
	check('foods').exists().isArray().withMessage('لیست غذا اجباری است.').custom( value => { return value.length > 0}).withMessage('لیست غذا خالی است.'),
	check('foods[*].food_data_id').exists().withMessage('آیدی غذا اجباری است.').isInt({min: 0}).withMessage('آیدی غذا نا معتبر است.'),
    check('foods[*].amount').exists().withMessage('مقدار غذا اجباری است.').isInt({min: 1}).withMessage('مقدار غذا معتبر نیست..'),
]


const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};


router.get("/", async (req,res) => {
    let [result] = await promisePool.query("SELECT * FROM restaurant_order");
    for(let order of result) {
        order.hasName = false;
        order.isDelivery = false;

        if(order.customer_id != null) {
            order.hasName = true
        }
        if(order.address_id != null) {
            order.isDelivery = true;
        }
    }
    res.status(200).send(result);
});

router.get('/:id',idValidator, handleErrorRejection, async (req,res) => {
    let order = ( await promisePool.query("SELECT * FROM restaurant_order WHERE id = ?",[req.params.id]) )[0][0];
    if(order != undefined) {
        order.hasName = false;
        order.isDelivery = false;

        if(order.customer_id != null) {
            order.hasName = true
        }

        if(order.address_id != null) {
            order.isDelivery = true;
        }
        res.status(200).send(order);
    } else {
        res.status(400).send({
            errors: [
                {
                    "value": req.params.id,
                    "msg": "آیدی فاکتور نا معتبر است.",
                    "param": "id",
                    "location": "params"
                }
            ]
        })
    }
});

router.delete('/:id', idValidator, handleErrorRejection , async (req,res) => {
    let [result] = await promisePool.query("DELETE FROM restaurant_order WHERE id = ?",[req.params.id]);
    res.status(204).send(result);
});

router.get('/:id/foods', idValidator, handleErrorRejection , async (req,res) => {
    let [result] = await promisePool.query("SELECT food_name,amount,price,(amount * price) as total_price,food_data_history.id as food_data_id FROM restaurant_order_foods join restaurant_order on restaurant_order_foods.order_id = restaurant_order.id join food_data_history on restaurant_order_foods.food_data_id = food_data_history.id WHERE restaurant_order.id = ?",[req.params.id]);
    res.status(200).send(result);
});

router.get('/:id/user' , idValidator, handleErrorRejection, async(req,res) => {
    let [result] = await promisePool.query("SELECT customer.* FROM restaurant_order join customer on restaurant_order.customer_id = customer.id where restaurant_order.id = ?",[req.params.id]);
    res.status(200).send(result[0]);
});

router.get('/:id/address' , idValidator, handleErrorRejection, async(req,res) => {
    let [result] = await promisePool.query("SELECT address.* FROM restaurant_order join address on restaurant_order.address_id = address.id where restaurant_order.id = ?",[req.params.id]);
    res.status(200).send(result[0]);
});

router.get('/:id/courier', idValidator,handleErrorRejection, async(req,res) => {
    let [result] = await promisePool.query("SELECT courier.*,courier_on_order.status FROM courier join courier_on_order on courier.id = courier_on_order.courier_id join restaurant_order on restaurant_order.id = courier_on_order.order_id WHERE restaurant_order.id = ?",[req.params.id])
    res.status(200).send(result[0]);
});


router.post('/',foodValidator, handleErrorRejection, async(req,res) => {
    try{
        let [result] = await promisePool.query("INSERT INTO restaurant_order(customer_id,address_id) VALUES(?,?)",[req.body.customer_id,req.body.address_id]);
        for(let food of req.body.foods) {
            await promisePool.query("INSERT INTO restaurant_order_foods(order_id,food_data_id,amount) VALUES(?,?,?)",[result.insertId,food.food_data_id,food.amount]);
        }
        res.status(201).send(result);
    }catch (e) {
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

router.put('/:id/address/:addrId', idValidator, addrIdValidator, handleErrorRejection, async (req,res) => {
    try {
      let [updateResult] = await promisePool.query("UPDATE restaurant_order SET address_id = ? WHERE id = ?",[req.params.addrId,req.params.id]);
      res.status(200).send(updateResult);
    } catch(e) {
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

router.put('/:id/customer/:customerId', idValidator, customerIdValidator, handleErrorRejection, async (req,res) => {
    try {
        let [updateResult] = await promisePool.query("UPDATE restaurant_order SET customer_id = ? WHERE id = ?",[req.params.customerId,req.params.id]);
        res.status(200).send(updateResult);
    } catch(e) {
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

router.delete('/:id/courier/:courierId', idValidator, courierIdValidator, handleErrorRejection, async (req,res) => {
    let [delResult] = await promisePool.query("DELETE FROM courier_on_order WHERE order_id = ? and courier_id = ?",[req.params.id,req.params.courierId]);
    res.status(204).send(delResult);
});

router.put('/:id/courier/:courierId',idValidator, courierIdValidator, handleErrorRejection, async (req,res) => {
    try {
        let [putResult] = await promisePool.query("INSERT INTO courier_on_order(order_id,courier_id) VALUES(?,?)",[req.params.id,req.params.courierId]);
        res.status(201).send(putResult);
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

router.patch('/:id/courier/:courierId/status', idValidator, courierIdValidator, statusValidator, handleErrorRejection, async(req,res) => {
    let [updateResult] = await promisePool.query("UPDATE courier_on_order SET status = ? WHERE order_id = ? and courier_id = ?",[req.body.status,req.params.id,req.params.courierId]);
    res.status(204).send(updateResult);
});

module.exports = router;