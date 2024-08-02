const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const rentAdminRouter = require("./routes/rentAdmin");
const rentProductRouter = require("./routes/rentProduct");
const userRouter = require("./routes/user");

const PORT = 3000;
const app = express();

const DB = "Pass your mongodb atlas connection lik"

app.use(express.json());

app.use(authRouter);
app.use(adminRouter);
app.use(rentAdminRouter);
app.use(productRouter);
app.use(rentProductRouter);
app.use(userRouter);


mongoose.connect(DB).then(() => {
    console.log("Connection successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected Port ${PORT}`);
});
