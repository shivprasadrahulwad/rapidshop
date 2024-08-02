// const express = require("express");
// const rentAdminRouter = express.Router();
// const rentAdmin = require("../middlewares/rent_admin");
// const { RentProduct } = require("../models/rentProduct");


const express = require('express');
const rentAdminRouter = express.Router();
const { Product } = require('../models/product'); // Adjust the path as necessary
const { RentProduct } = require('../models/rentProduct');
const rentAdmin = require('../middlewares/rent_admin');
const User = require('../models/user');




rentAdminRouter.post("/admin/copy-product", async (req, res) => {
  try {
    console.log("Request body:", req.body); // Print the entire request body for debugging

    const { id, userId } = req.body; // Ensure userId and id are extracted from req.body

    if (!userId || typeof userId !== 'string') {
      return res.status(400).json({ error: "Valid User ID is required" });
    }

    console.log("User ID to check:", userId); // Log the userId

    // Find the user by userId
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }

    // Find the product by id
    const product = await Product.findById(id);

    if (!product) {
      return res.status(404).json({ error: "Product not found" });
    }

    // Check if product images array is valid
    if (!Array.isArray(product.images) || product.images.length === 0) {
      return res.status(400).json({ error: "Product must have at least one image" });
    }

    // Add the product to the user's cart
    user.cart.push({
      product: {
        name: product.name,
        description: product.description,
        price: product.price,
        discountPrice: product.discountPrice,
        category: product.category,
        subCategory: product.subCategory,
        quantity: product.quantity,
        // images: product.images,
        // Add other necessary fields from the product
      }
    });

    // Save the user document with the updated cart
    await user.save();

    res.json({ message: "Product added to cart successfully" });
  } catch (e) {
    console.error("Error:", e.message); // Log the error for debugging
    res.status(500).json({ error: e.message });
  }
});




//copy product
// rentAdminRouter.post("/admin/copy-product", rentAdmin, async (req, res) => {
//   try {
//     const { id } = req.body;
//     let product = await Product.findById(id);

//     if (!product) {
//       return res.status(404).json({ error: "Product not found" });
//     }

//     // Create a new RentProduct document
//     let rentProduct = new RentProduct({
//       name: product.name,
//       description: product.description,
//       price: product.price,
//       discountPrice: product.discountPrice,
//       category: product.category,
//       subCategory: product.subCategory,
//       quantity: product.quantity,
//       images: product.images, // Ensure images are copied
//       // Copy other fields as necessary
//     });

//     await rentProduct.save();

//     res.json(rentProduct);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

//addProduct
rentAdminRouter.post("/rentAdmin/add-product", rentAdmin, async (req, res) => {
  try {
    const { name , description , category , subcategory ,price , discountPrice ,images ,quantity } = req.body;
    let rentProduct = new RentProduct({
      name ,
      description,
      category,
      subcategory,
      price,
      discountPrice,
      images,
      quantity,
    })
    rentProduct = await rentProduct.save();
    res.json(rentProduct);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get all your products
rentAdminRouter.get("/rentAdmin/get-products", rentAdmin, async (req, res) => {
  try {
    const rentProduct = await RentProduct.find({});
    res.json(rentProduct);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Delete the product
rentAdminRouter.post("/rentAdmin/delete-product", rentAdmin, async (req, res) => {
  try {
    const { id } = req.body;
    let rentProduct = await RentProduct.findByIdAndDelete(id);
    res.json(rentProduct);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


module.exports = rentAdminRouter;