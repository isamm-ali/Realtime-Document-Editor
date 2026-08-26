import mongoose from "mongoose";

export const connectDB = async () => {
  try {
    const db = process.env.MONGO_CONNECTION;
    await mongoose.connect(db);
    console.log("Database connection successful");
  } catch (error) {
    console.error("Database connection failed:", error);
  }
};
