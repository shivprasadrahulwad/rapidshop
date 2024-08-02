const mongoose = require("mongoose");


const rentProductSchema = mongoose.Schema({
  name: {
    type: String,
    // required: true,
    trim: true,
  },

  description: {
    type: String,
    // required: true,
    trim: true,
  },

  category:{
    type: String,
    // required:true,
    trim:true,
  },

  subCategory: {
    type: String,
    // required: true,
    trim: true,
  },

  
  price: {
    type: Number,
    // required: true,
    trim: true,
  },

  discountPrice: {
    type: Number,
    // required: true,
    trim: true,
  },
  
  images: [
    {
      type: String,
      // required: true,
    },
  ],

  quantity: {
    type: String,
    required: true,
  },

});

const RentProduct = mongoose.model("RentProduct", rentProductSchema);
module.exports = { RentProduct, rentProductSchema };