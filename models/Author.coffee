mongoose = require 'mongoose'
Schema = mongoose.Schema

authorSchema = Schema(
  _id: Number
  name: [{ type: String, trim: true }]
  # TODO What about aliases?
)

exports.Author = mongoose.model "Author", authorSchema