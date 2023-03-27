// Importing module
import https from "https";
import fs from "fs";
import cors from "cors";
import express from "express";
import { ApiHandler } from "./utilities/api_handler";

const app = express();
app.use(cors());
const PORT: Number = 3000;

// Handling GET / Request
app.get("/", cors(), async (req, res) => {
  console.log(req.query);

  // Manage params errors
  if (req.query.lat === undefined || req.query.lon === undefined) {
    res.status(400).send({ err_msg: "Bad params" });
    return;
  }

  let data = await ApiHandler.getForecast(45.0703, 7.6869);

  console.log(data);
  res.send(data);
});

// Server setup

app.listen(3000, () => {
  console.log("server is runing at port 3000");
});
