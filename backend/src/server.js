import dns from 'dns';
import dotenv from 'dotenv';
import { app } from './app.js';
import { connectDB } from './config/database.js';

dns.setServers(['1.1.1.1', '8.8.8.8']);
dotenv.config();
const PORT = process.env.PORT;

await connectDB();

app.listen(PORT, () => {
  console.log(`Server is running on Port ${PORT}`);
});