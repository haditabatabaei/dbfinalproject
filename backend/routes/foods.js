const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی غذا اجباری است.').isInt({min: 0}).withMessage('آیدی غذا نا معتبر است.')
];

const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};

const foodValidation = [
    check('name').exists().withMessage('نام اجباری است.').isLength({min : 1, max : 50}).withMessage('نام اجباری است.'),
    check('price').exists().withMessage('قیمت غذا اجباری است.').isInt().withMessage('قیمت غذا باید عدد معتبر باشد.')
];

router.get('/', async (req, res) => {
    let [foodNames] = await promisePool.query("SELECT food.id as food_id,food.name as name FROM food");
    for(let food of foodNames) {
        let [foodDataResult] = await promisePool.query("SELECT price,food_data_history.id as food_data_id from food_data_history WHERE food_name = ? ORDER BY updated DESC LIMIT 1",[food.name]);
        food.price = foodDataResult[0].price;
        food.food_data_id = foodDataResult[0].food_data_id;
    }
    res.status(200).send(foodNames);
});

router.get('/:id',idValidator,handleErrorRejection, async (req,res) => {
   let [foodresult] = await promisePool.query("SELECT food.id as food_id,food_data_history.id as food_data_id,food.name,food_data_history.price,food_data_history.updated FROM food join food_data_history on food.name = food_data_history.food_name WHERE food.id = ? ORDER BY updated DESC LIMIT 1",[req.params.id]);
   return res.status(200).send(foodresult[0]);
});

router.delete('/:id', idValidator,handleErrorRejection, async (req,res) => {
	let [result] = await promisePool.query("DELETE FROM food WHERE id = ?",[req.params.id]);
	res.status(204).send(result);
});

router.post('/', foodValidation,handleErrorRejection, async (req,res) => {
   let [insertInFoodResult] = await promisePool.query("INSERT INTO food(name) VALUES(?)",[req.body.name]);
   let [insertIntoFoodDataResult] = await promisePool.query("INSERT INTO food_data_history(food_name,price) VALUES(?,?)",[req.body.name,req.body.price]);
   res.status(201).send([insertInFoodResult, insertIntoFoodDataResult]);
});

router.patch('/:id',idValidator, foodValidation,handleErrorRejection, async (req,res) => {
    let [updateFoodListResult] = await promisePool.query("UPDATE food SET name = ? WHERE id = ?",[req.body.name,req.params.id]);
    let [insertIntoFoodDataResult] = await promisePool.query("INSERT INTO food_data_history(food_name,price) VALUES(?,?)",[req.body.name,req.body.price]);
    res.status(204).send([updateFoodListResult, insertIntoFoodDataResult]);
});


module.exports = router;