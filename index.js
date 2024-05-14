import express from "express";
import todoRoute from "./routes/route.js";

const app = express();

app.use(express.json());

app.use("/api/todos", todoRoute);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log("Server listening on port " + PORT);
});