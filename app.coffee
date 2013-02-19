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

###
Module dependencies.
###

flash = require('connect-flash')
express = require('express')
http = require('http')
path = require('path')
stylus = require('stylus')
nconf = require('nconf')
passport = require('passport')

# load configuration
nconf.env()
    .file('user', 'config.json')
    .file('defaults', 'config.defaults');

if (nconf.get('session:secret') == "your secret here")
    console.warn('Your session secret has not been changed from the default value. Please check your configuratrion.');


if (nconf.get('cookies:secret') == "your secret here")
    console.warn('Your cookie secret has not been changed from the default value. Please check your configuration.');

# create app
app = express()

# configure the app
app.set('port', nconf.get('server:port'))
	.set('domain', nconf.get('server:domain'))
	.set('views', path.join(__dirname, 'views'))
	.set('view engine', 'jade')
# configure the middlewares
	.use(express.favicon())
	.use(express.logger('dev'))
	.use(express.bodyParser())
	.use(express.methodOverride())
	.use(express.cookieParser(nconf.get('cookies:secret')))
	.use(express.session({ secret: nconf.get('session:secret')}))
	.use(flash())
	.use(passport.initialize())
	.use(passport.session())
	.use(express.csrf())
	.use(stylus.middleware({
	    src: path.join(__dirname, 'public'),
	    compile: (str, path) ->
	        verbose = app.get("env") == "development"
	        return stylus(str)
	            .set('filename', path)
	            .set('compress', true)
	            .set('warn', verbose)
	            .set('linenos', verbose)
	    }))
	.use(express.static(path.join(__dirname, 'public')))
	.use(app.router)

# configure the middlewares for development
app.configure('development', ->
    app.locals({pretty: true})
    # app.use(express.errorHandler())
);

# configure the controllers
[
	'site',
	'errors'
].map (controllerName) ->
	controller = require ('./controllers/' + controllerName)
	controller.setup app

# start the server
http.createServer(app).listen(app.get('port'), app.get('domain'), ->
    console.log("Express server listening on " + app.get('domain') + ":" + app.get('port'));
)
