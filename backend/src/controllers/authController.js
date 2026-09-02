import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { User } from "../models/user.js";

const normalizeEmail = (email) => email?.trim().toLowerCase();

const createToken = (userId) => {
  const secret = process.env.JWT_SECRET;
  return jwt.sign(
    {
      userId: userId.toString(),
    },
    secret,
    {
      expiresIn: "7d",
    },
  );
};

const publicUser = (user) => ({
  _id: user._id,
  username: user.username,
  email: user.email,
  pfp: user.pfp,
});

export const signup = async (req, res) => {
  try {
    const username = req.body.username?.trim();
    const email = normalizeEmail(req.body.email);
    const password = req.body.password;
    const pfp = req.body.pfp?.trim();
    if (!username || !email || !password || !pfp) {
      return res.status(400).json({
        message: "All fields are required",
      });
    }
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(409).json({
        message: "User already exists!",
      });
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create({
      username,
      email,
      password: hashedPassword,
      pfp,
    });
    return res.status(201).json({
      message: "Account created successfully!",
      user: publicUser(user),
    });
  } catch (error) {
    if (error?.code === 11000) {
      return res.status(409).json({
        message: "User already exists!",
      });
    }
    console.error("Signup error:", error);
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const signin = async (req, res) => {
  try {
    const email = normalizeEmail(req.body.email);
    const password = req.body.password;

    if (!email || !password) {
      return res.status(400).json({
        message: "Email and password are required",
      });
    }
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({
        message: "Email or Password is invalid",
      });
    }
    const passwordMatches = await bcrypt.compare(password, user.password);
    if (!passwordMatches) {
      return res.status(401).json({
        message: "Email or Password is invalid",
      });
    }
    const token = createToken(user._id);
    return res.status(200).json({
      message: "Login successful!",
      token,
      user: publicUser(user),
    });
  } catch (error) {
    console.error("Signin error:", error);
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
  } catch (error) {
    console.error("Get user info error:", error);
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};
