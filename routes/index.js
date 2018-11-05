var express = require('express');
var router = express.Router();
var db = require('../database/db');
var exphbs = require('express-handlebars');

// Check if logged in, Get Homepage
router.get('/', ensureAuthenticated, function(req, res){
	res.render('index');
});

function ensureAuthenticated(req, res, next){
	if(req.isAuthenticated()){
		return next();
	} else {
		res.redirect('/users/login');
	}
}
module.exports = router;
