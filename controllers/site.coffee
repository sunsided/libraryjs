###
 library.js
 Copyright © 2013 Markus Mayer <widemeadows@gmail.com>.

 This source code is licensed under the EUPL, Version 1.1 or - as soon they will be approved
 by the European Commission - subsequent versions of the EUPL (the "Licence"); you may not
 use this work except in compliance with the Licence. You may obtain a copy of the Licence at:
 <http://joinup.ec.europa.eu/software/page/eupl/licence-eupl>

 A copy is also distributed with this source code.
 Unless required by applicable law or agreed to in writing, software distributed under the
 Licence is distributed on an “AS IS” basis, without warranties or conditions of any kind.
###

passport = require('passport')

exports.SiteController = class SiteController
	###
	constructor: (@name) ->
		undefined
	###

	index: (req, res) ->
		variables = {
		title: 'Express',
		}
		res.status(200)
			.render('index.jade', variables);

	showLogin: (req, res) ->
		variables = {
		title: 'Express',
		username: '',
		token: req.session._csrf,
		message: req.flash('error')
		}
		res.status(200)
			.render('login.jade', variables);

	performLogin: (req, res) ->
		variables = {
		title: 'Express ... welp',
		username: req.body.user,
		token: req.session._csrf,
		}
		res.status(200)
			.render('login.jade', variables);

exports.setup = (app) ->
	controller = new exports.SiteController

	# configure passport
	LocalStrategy = require('passport-local').Strategy;

	passport.use(new LocalStrategy(
		(username, password, done) ->
			console.warn("sunside was here #{username}:#{password}");
			return done(null, false, { message: 'Incorrect username.' })
			###
			User.findOne({ username: username }, (err, user) ->
				if (err)
					return done(err)

				if (!user)
					return done(null, false, { message: 'Incorrect username.' })

				if (!user.validPassword(password))
					return done(null, false, { message: 'Incorrect password.' })

				return done(null, user);
			);
			###
	));

	# Routes
	route = '/'
	app.get route, controller.index

	route = '/login'
	app.get route, controller.showLogin
	#app.post route, controller.performLogin
	app.post(route, passport.authenticate('local',
		{
			successRedirect: '/',
			failureRedirect: '/login',
			failureFlash: true
		}
	));
