mongoose = require 'mongoose'
Schema = mongoose.Schema

bookSchema = Schema(
  _id: Number

  # Book title
  title: [{ type: String, trim: true }]

  # Book edition
  edition: { type: Number, default: 0 }

  # Publication date
  publication: Date

  # List of identifiers
  identifiers: [
    type: { type: Number, ref: 'Identifier' }
    value: String
  ]

  # Publisher reference
  publisher: { type: Number, ref: 'Publisher' }

  # List of author references
  authors: [{ type: Number, ref: 'Author' }]

  # List of keywords
  keywords: [{ type: String, trim: true }]

  # Associated document files
  documents: [
    type: { type: Number, ref: 'DocumentType' }
    path: String
  ]

  # Cover image path
  cover: { type: String, trim: true }

  # Additional files (e.g. CD files, ...)
  attachments: [
    path: String
  ]
)

exports.Book = mongoose.model "Book", bookSchema