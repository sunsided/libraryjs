/*
 * library.js
 * Copyright © 2013 Markus Mayer <widemeadows@gmail.com>.
 *
 * This source code is licensed under the EUPL, Version 1.1 or - as soon they will be approved
 * by the European Commission - subsequent versions of the EUPL (the "Licence"); you may not
 * use this work except in compliance with the Licence. You may obtain a copy of the Licence at:
 * <http://joinup.ec.europa.eu/software/page/eupl/licence-eupl>
 *
 * A copy is also distributed with this source code.
 * Unless required by applicable law or agreed to in writing, software distributed under the
 * Licence is distributed on an “AS IS” basis, without warranties or conditions of any kind.
 */

/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session());
  app.use(app.router);
  app.use(require('stylus').middleware(__dirname + '/public'));
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/', routes.index);
app.get('/users', user.list);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
