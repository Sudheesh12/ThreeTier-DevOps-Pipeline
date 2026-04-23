const express = require("express");
const redis = require("redis");

const app = express();

// Create Redis client
const client = redis.createClient({
  url: "redis://redis:6379"
});

// Handle Redis connection errors
client.on("error", (err) => {
  console.error("Redis error:", err);
});

// Connect to Redis
(async () => {
  try {
    await client.connect();
    console.log("Connected to Redis");
  } catch (err) {
    console.error("Failed to connect to Redis:", err);
  }
})();

// Common handler function
async function handleRequest(req, res) {
  try {
    let count = await client.get("count");
    count = count ? parseInt(count) + 1 : 1;

    await client.set("count", count);

    res.send(`Hello from backend! Visitor count: ${count}`);
  } catch (err) {
    console.error(err);
    res.status(500).send("Error connecting to Redis");
  }
}

// Routes
app.get("/", handleRequest);
app.get("/api", handleRequest);

// Health check (optional but useful for K8s)
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});

// Start server
const PORT = 3000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend running on port ${PORT}`);
});