const express = require("express");
const rentProductRouter = express.Router();
const auth = require("../middlewares/auth");
const { RentProduct } = require("../models/rentProduct");


rentProductRouter.get("/api/prod/", auth, async (req, res) => {
  try {
    console.log(req.query.category);
    const products = await RentProduct.find({ category: req.query.category });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = rentProductRouter;