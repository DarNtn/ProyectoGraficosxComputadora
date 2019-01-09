var express = require('express');
var app = express();

app.use('/', express.static('index.html'));
app.use(express.static('images'));

app.listen(3000);