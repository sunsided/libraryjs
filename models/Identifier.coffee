mongoose = require 'mongoose'
Schema = mongoose.Schema

identifierSchema = Schema(
  _id: Number
  name: [{ type: String, trim: true, lowercase: true }]
  description: [{ type: String, trim: true }]
)

exports.Identifier = mongoose.model "Identifier", identifierSchema