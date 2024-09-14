const express = require("express");
const mongoose = require("mongoose");
const redis = require("redis");

const backendPort = process.env.PORT || 3001; // Porta para o backend
const routes = require("./routes");

main().catch((err) => console.log(err));

async function main() {
  const username = process.env.MONGO_INITDB_ROOT_USERNAME;
  const password = process.env.MONGO_INITDB_ROOT_PASSWORD;
  const host = process.env.MONGO_INITDB_HOST || "todo-db";
  const port = process.env.MONGO_INITDB_PORT || "27017";
  const database = "todos";
  
  const uri = `mongodb://${username}:${password}@${host}:${port}/${database}?authSource=admin`;
  console.log(`Connecting to MongoDB with URI: ${uri}`);  

  try {
    await mongoose.connect(uri, {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    });
    console.log('MongoDB connected successfully');
  } catch (error) {
    console.error('Error connecting to MongoDB:', error);
  }

  const app = express();
  app.use(express.static("public"));
  app.use(express.json());
  app.use("/api", routes);

  app.listen(backendPort, () => {
    console.log(`Server is listening on port: ${backendPort}`);
  });
}
