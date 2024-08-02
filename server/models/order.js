const mongoose = require("mongoose");
const { productSchema } = require("./product");

const orderSchema = mongoose.Schema({
  products: [
    {
      product: {
        type: productSchema,
        required: true
      },
      quantity: {
        type: Number,
        required: true
      }
    }
  ],
  totalPrice: {
    type: Number,
    required: true
  },
  totalSave: {
    type: Number,
    default: 0
  },
  address: {
    type: String,
    // required: true
  },
  userId: {
    type: String,
    required: true
  },
  orderedAt: {
    type: Number,
    required: true
  },
  instruction: [
    {
      type: String,
      
    }
  ],
  tips: {
    type: String
  },
  status: {
    type: Number,
    default: 0
  },
  shopId: {
    type: String
  }
});

const Order = mongoose.model("Order", orderSchema);

module.exports = Order;
