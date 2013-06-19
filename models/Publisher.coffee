mongoose = require 'mongoose'
Schema = mongoose.Schema

publisherSchema = Schema(
  _id: Number
  name: [{ type: String, trim: true }]
)

exports.Publisher = mongoose.model "Publisher", publisherSchema