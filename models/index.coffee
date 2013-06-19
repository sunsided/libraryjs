fs = require 'fs'

modelsPath = __dirname
modelFiles = fs.readdirSync(modelsPath)

modelFiles.forEach (file) ->
  console.log "Adding model: " + file
  require modelsPath + '/' + file

###

# Mongoose models
exports.Author = require './Author'
exports.Book = require './Book'
exports.DocumentType = require './DocumentType'
exports.Identifier = require './Identifier'
exports.Publisher = require './Publisher'

# Custom models
exports.NotFound = require './NotFound'
###