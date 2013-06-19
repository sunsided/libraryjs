mongoose = require 'mongoose'
Schema = mongoose.Schema

documentTypeSchema = Schema(
  _id: Number
  name: [{ type: String, trim: true, lowercase: true }]
  mimeType: [{ type: String, trim: true, default: null }]
)

exports.DocumentType = mongoose.model "DocumentType", documentTypeSchema