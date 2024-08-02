const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const { User } = require('../models/user');
const { Product } = require("../models/product");

productRouter.get("/api/products/", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await Product.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

productRouter.get("/api/product/", auth, async (req, res) => {
  try {
    console.log(req.query.shopId);
    const products = await Product.find({ shopId: req.query.shopId });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


productRouter.get("/api/products/search/:productName", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.productName, $options: "i" },
    });

    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});







// //fetch products from other users cart
// productRouter.get("/api/user/:userId/cart/products", auth, async (req, res) => {
//   try {
//     const user = await User.findById(req.params.userId).populate('cart.product');
//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }
//     res.json(user.cart.map(item => item.product));
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });



module.exports = productRouter;