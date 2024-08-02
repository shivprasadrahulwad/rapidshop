const mongoose = require("mongoose");
// const { productSchema } = require("./product");

const fshopSchema = mongoose.Schema({
    products: [
        {
          product: productSchema,
        //   quantity: {
        //     type: Number,
            
        //   },
        },
      ],

  price: {
    type: Number,
    required: true,
  },

  discountPrice: {
    type: String,
    // required: true,
  },

  time : {
    type : String,
    required : true,
  },

  
  quantity: {
    type: Number,
    required,
  },
});

const Fshop = mongoose.model("Fshop", fshopSchema);
module.exports = Fshop;