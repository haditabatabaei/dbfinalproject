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

router.get('/totalordersprice', async (req,res) => {
	let [result] = await promisePool.query("SELECT sum(order_prices.total_price) as total_price_of_all FROM (SELECT amount,price,(amount * price) as total_price, order_id FROM restaurant_order_foods join restaurant_order on restaurant_order_foods.order_id = restaurant_order.id join food_data_history on restaurant_order_foods.food_data_id = food_data_history.id) as order_prices");
	res.status(200).send(result[0]);
});

router.get('/totalsuppliersordersprice', async (req,res) => {
	let [result] = await promisePool.query("SELECT sum(order_prices.total_price) as total_price_of_all FROM (SELECT amount,price,(amount * price) as total_price, supplier_order_id FROM supplier_order_items join supplier_order on supplier_order_items.supplier_order_id = supplier_order.id join material_data_history on supplier_order_items.material_data_id = material_data_history.id) as order_prices");
	res.status(200).send(result[0]);
});

router.get('/profitofalltime', async (req,res) => {
	let [gainResult] = await promisePool.query("SELECT sum(order_prices.total_price) as total_price_of_all FROM (SELECT amount,price,(amount * price) as total_price, order_id FROM restaurant_order_foods join restaurant_order on restaurant_order_foods.order_id = restaurant_order.id join food_data_history on restaurant_order_foods.food_data_id = food_data_history.id) as order_prices");
	let [consumeResult] = await promisePool.query("SELECT sum(order_prices.total_price) as total_price_of_all FROM (SELECT amount,price,(amount * price) as total_price, supplier_order_id FROM supplier_order_items join supplier_order on supplier_order_items.supplier_order_id = supplier_order.id join material_data_history on supplier_order_items.material_data_id = material_data_history.id) as order_prices");
	console.log(gainResult);
	console.log(consumeResult);
	res.status(200).json({ "profit" : gainResult[0].total_price_of_all - consumeResult[0].total_price_of_all});
})

router.get('/users/:id/mostfavfoods', async(req,res) => {
	let [favFoodsResult] = await promisePool.query("select food_name, sum(amount) as total_picks from customer join restaurant_order on customer.id = restaurant_order.customer_id join restaurant_order_foods on restaurant_order_foods.order_id = restaurant_order.id join food_data_history on food_data_history.id = restaurant_order_foods.food_data_id where customer.id = ? group by food_name order by total_picks DESC",[req.params.id]);
	res.status(200).send(favFoodsResult)
});

router.get('/foods/mostfavfoods', async(req,res) => {
	let [favFoodsResult] = await promisePool.query("select food_name,sum(amount) as total_picks from restaurant_order join restaurant_order_foods on restaurant_order.id = restaurant_order_foods.order_id join food_data_history on food_data_history.id = restaurant_order_foods.food_data_id group by food_name order by total_picks DESC");
	res.status(200).send(favFoodsResult)
})

router.get('/totalordersprice/date/:datestr', async (req,res) => {
	let [priceInDayResult] = await promisePool.query(
	"SELECT SUM(total_price_in_day.total_price_in_hour) as total_sum FROM" +
	"(SELECT restaurant_order.issue_date,SUM(amount*price) as total_price_in_hour " + 
	"FROM restaurant_order_foods join restaurant_order on restaurant_order_foods.order_id = restaurant_order.id " + 
	"join food_data_history on restaurant_order_foods.food_data_id = food_data_history.id " + 
	"where (SELECT DATE(issue_date)) = (SELECT CONVERT(?, DATE)) group by issue_date ) as total_price_in_day",[req.params.datestr]);
	res.status(200).send(priceInDayResult[0]);
});

router.get('/totalorderspricesdata', async (req,res) => {
	let [availableDates] = await promisePool.query("SELECT DISTINCT just_dates.just_date FROM (SELECT DATE(issue_date) as just_date FROM restaurant_order) as just_dates");
	for(let date of availableDates) {
		let [priceInDayResult] = await promisePool.query(
	"SELECT SUM(total_price_in_day.total_price_in_hour) as total_sum FROM" +
	"(SELECT restaurant_order.issue_date,SUM(amount*price) as total_price_in_hour " + 
	"FROM restaurant_order_foods join restaurant_order on restaurant_order_foods.order_id = restaurant_order.id " + 
	"join food_data_history on restaurant_order_foods.food_data_id = food_data_history.id " + 
	"where (SELECT DATE(issue_date)) = (SELECT CONVERT(?, DATE)) group by issue_date ) as total_price_in_day",[date.just_date]);
	date.total_gain = priceInDayResult[0].total_sum;
	}
	res.status(200).send(availableDates);
});

router.get('/totalsupplierordersprice/date/:datestr', async (req,res) => {
	let [priceInDayResult] = await promisePool.query(
	"SELECT SUM(total_price_in_day.total_price_in_hour) as total_sum FROM" +
	"(SELECT supplier_order.issue_date,SUM(amount*price) as total_price_in_hour " + 
	"FROM supplier_order_items join supplier_order on supplier_order_items.order_id = supplier_order.id " + 
	"join material_data_history on supplier_order_items.material_data_id = material_data_history.id " + 
	"where (SELECT DATE(issue_date)) = (SELECT CONVERT(?, DATE)) group by issue_date ) as total_price_in_day",[req.params.datestr]);
	res.status(200).send(priceInDayResult[0]);
});

router.get('/totalsupplierorderspricesdata', async (req,res) => {
	let [availableDates] = await promisePool.query("SELECT DISTINCT just_dates.just_date FROM (SELECT DATE(issue_date) as just_date FROM supplier_order) as just_dates");
	for(let date of availableDates) {
		let [priceInDayResult] = await promisePool.query(
	"SELECT SUM(total_price_in_day.total_price_in_hour) as total_sum FROM" +
	"(SELECT supplier_order.issue_date,SUM(amount*price) as total_price_in_hour " + 
	"FROM supplier_order_items join supplier_order on supplier_order_items.supplier_order_id = supplier_order.id " + 
	"join material_data_history on supplier_order_items.material_data_id = material_data_history.id " + 
	"where (SELECT DATE(issue_date)) = (SELECT CONVERT(?, DATE)) group by issue_date ) as total_price_in_day",[date.just_date]);
	date.total_gain = priceInDayResult[0].total_sum;
	}
	res.status(200).send(availableDates);
});


module.exports = router;