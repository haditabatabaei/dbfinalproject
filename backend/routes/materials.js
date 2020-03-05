const express = require('express');
const router = express.Router();
const {promisePool} = require ('./../Config.js');
const {check, validationResult} = require('express-validator');

const idValidator = [
    check('id').exists().withMessage('آیدی مواد اولیه اجباری است.').isInt({min: 0}).withMessage('آیدی مواد اولیه نا معتبر است.')
];

const materialValidation = [
    check('name').exists().withMessage('نام اجباری است.').isLength({min : 1,max : 50}).withMessage("نام باید حداقل 1 تا 50 کاراکتر باشد"),
    check('price').exists().withMessage('قیمت مواد اولیه اجباری است.').isInt().withMessage('قیمت مواد اولیه باید عدد معتبر باشد.')
];


const handleErrorRejection = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({errors: errors.array()})
    } else next();
};


router.get('/', async (req, res) => {
    let [materialNames] = await promisePool.query("SELECT material.id as material_id,material.name as name FROM material");
    for(let material of materialNames) {
        let [materialDataResult] = await promisePool.query("SELECT price,material_data_history.id as material_data_id FROM material_data_history WHERE material_name = ? ORDER BY updated DESC LIMIT 1",[material.name]);
        material.price = materialDataResult[0].price;
        material.material_data_id = materialDataResult[0].material_data_id;
    }
    res.status(200).send(materialNames);
});

router.get('/:id',idValidator,handleErrorRejection, async (req,res) => {
    let [materialResult] = await promisePool.query("SELECT material.id as material_id,material_data_history.id as material_data_id,material.name,material_data_history.price,material_data_history.updated FROM material join material_data_history on material.name = material_data_history.material_name WHERE material.id = ? ORDER BY updated DESC LIMIT 1",[req.params.id]);
    return res.status(200).send(materialResult[0]);
});

router.delete('/:id', idValidator,handleErrorRejection, async (req,res) => {
    res.status(200).send((await promisePool.query("DELETE FROM material WHERE id = ?",[req.params.id]))[0][0]);
});

router.post('/',materialValidation ,handleErrorRejection, async (req,res) => {
    let [insertInfoMaterialResult] = await promisePool.query("INSERT INTO material(name) VALUES(?)",[req.body.name]);
    let [insertInfoMaterialDataResult] = await promisePool.query("INSERT INTO material_data_history(material_name,price) VALUES(?,?)",[req.body.name,req.body.price]);
    res.status(200).send([insertInfoMaterialResult, insertInfoMaterialDataResult]);
});

router.patch('/:id',idValidator, materialValidation, handleErrorRejection, async (req,res) => {
    let [updateMaterialFoodListResult] = await promisePool.query("UPDATE material SET name = ? WHERE id = ?",[req.body.name,req.params.id]);
    let [insertIntoMaterialDataResult] = await promisePool.query("INSERT INTO material_data_history(material_name,price) VALUES(?,?)",[req.body.name,req.body.price]);
    res.status(200).send([updateMaterialFoodListResult, insertIntoMaterialDataResult]);
});


module.exports = router;