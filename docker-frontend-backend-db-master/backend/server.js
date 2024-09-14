const express = require("express");
const cors = require('cors');
const mongoose = require("mongoose");
const port = 3001;
const routes = require("./routes");

main().catch((err) => console.log(err));

async function main() {
  const mongoUser=process.env.MONGO_INITDB_ROOT_USERNAME;
  const mongoPass=process.env.MONGO_INITDB_ROOT_PASSWORD;
  const mongoHost = 'todo-db';
  const mongPort = '27017';
  const mongoDb = 'admin';

  console.log(`mongodb://${mongoUser}:${mongoPass}@${mongoHost}:${mongPort}/${mongoDb}`);

  await mongoose.connect(`mongodb://${mongoUser}:${mongoPass}@${mongoHost}:${mongPort}/${mongoDb}`, {
    useUnifiedTopology: true,
    useNewUrlParser: true,
  });
  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use("/api", routes);

  app.listen(port, () => {
    console.log(`Server is listening on port: ${port}`);
  });
}
