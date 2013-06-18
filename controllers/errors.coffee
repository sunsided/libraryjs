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

{NotFound} = require('../models/NotFound')

exports.ErrorsController = class ErrorsController

  showError: (req, res) ->
    errorId = (Number) req.params.errorId
    # console.log("switching error #{errorId}");

    switch errorId
      when 404
        throw new NotFound
        break

      when 500
        throw new Error 'This is a synthetic 500 error'
        break

      else
        throw new Error "An internal server error (#{errorId}) has encountered"
        break

  errorHandler: (err, req, res, next) ->
    if err instanceof NotFound
      variables = {
        title: '404 - Not Found',
        description: 'Sorry, pal.',
      }
      res.status(404).render 'errors/404.jade', variables
    else
      console.error(err.stack);
      variables = {
        title: 'The Server Encountered an Error',
        description: err,
        stack: err.stack
      }
      res.status(500).render 'errors/500.jade', variables
    return

exports.setup = (app) ->
  controller = new exports.ErrorsController

  # Error handling
  app.use controller.errorHandler

  # Synthetic errors
  route = '/errors/:errorId(\\d+)'
  app.get route, controller.showError

  # Error 500
  route = '/500'
  app.get route, (req, res) ->
    res.redirect('/errors/500')

  # Catchall route
  route = '/*'
  app.get route, (req, res) ->
    res.redirect('/errors/404')
