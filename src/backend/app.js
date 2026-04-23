const express = require("express");
const redis = require("redis");

const app = express();
const client = redis.createClient({
  url: "redis://redis:6379"
});

client.connect();

app.get("/", async (req, res) => {
  let count = await client.get("count");
  count = count ? parseInt(count) + 1 : 1;
  await client.set("count", count);

  res.send(`Hello from backend! Visitor count: ${count}`);
});

app.listen(3000, () => {
  console.log("Backend running on port 3000");
});

