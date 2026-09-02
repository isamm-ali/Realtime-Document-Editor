import dns from "dns";
import dotenv from "dotenv";
import http from "http";
import { app } from "./app.js";
import { connectDB } from "./config/database.js";
import { Server } from "socket.io";
import { socketServer } from "./socket/socketServer.js";

dns.setServers(["1.1.1.1", "8.8.8.8"]);
dotenv.config();
const PORT = process.env.PORT;

const httpServer = http.createServer(app);
const io = new Server(httpServer, {
  cors: {
    origin: "*",
  },
});
socketServer(io);

try {
  await connectDB();
} catch (error) {
  console.error("Database connection failed:", error);
  process.exit(1);
}

httpServer.listen(PORT, () => {
  console.log(`Server is running on Port ${PORT}`);
});