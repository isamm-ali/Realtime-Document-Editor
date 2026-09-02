import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { User } from "../models/user.js";

export const signup = async (req, res) => {
  try {
    const { username, email, password, pfp } = req.body;
    if (!username || !email || !password || !pfp) {
      return res.status(400).json({ message: "All fields are required" });
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    await User.create({ email, pfp, username, password: hashedPassword });
    return res.json({ message: "Account created successfully!" });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({ message: "User already exists!" });
    }
    console.error(error);
    return res.status(500).json({ message: "Something went wrong" });
  }
};

export const signin = async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
    const user = await User.findOne({ email: email });
    if (!user) {
      return res.status(401).json({ message: "Email or Password is invalid" });
    } else {
      const passMatch = await bcrypt.compare(password, user.password);
      if (passMatch) {
        const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
          expiresIn: "7d",
        });
        return res.status(200).json({ message: "Login successful!", token });
      } else {
        return res.status(401).json({ message: "Email or Password is invalid" });
      }
    }
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const getinfo = async (req, res) => {
  try {
    const user = await User.findById(req.user.userId).select("-password");
    if (!user) {
      return res.status(404).json({
        message: "User not found",
      });
    }
    return res.status(200).json({
      user,
    });
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};