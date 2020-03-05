const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
// const moment = require('moment');
const cors = require('cors');

const app = express();
const users = require('./routes/users');
const couriers = require('./routes/couriers');
const foods = require('./routes/foods');
const addresses = require('./routes/addresses');
const orders = require('./routes/orders');
const suppliers = require('./routes/suppliers');
const materials = require('./routes/materials');
const supplierOrders = require('./routes/supplierOrders');
const reports = require('./routes/reports');
const logs = require('./routes/logs');

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/api/v1/users',users);
app.use('/api/v1/couriers', couriers);
app.use('/api/v1/foods', foods);
app.use('/api/v1/addresses', addresses);
app.use('/api/v1/orders', orders);
app.use('/api/v1/suppliers', suppliers);
app.use('/api/v1/materials', materials);
app.use('/api/v1/supplierorders',supplierOrders);
app.use('/api/v1/reports',reports);
app.use('/api/v1/logs',logs);

module.exports = app;