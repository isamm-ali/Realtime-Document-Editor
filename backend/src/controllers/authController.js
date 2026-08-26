import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { User } from "../models/user.js";

export const signup = async (req, res) => {
  try {
    const { username, email, password, pfp } = req.body;

    if (!username || !email || !password || !pfp) {
      return res.status(400).json({
        message: "All fields are required",
      });
    }

    let user = await User.findOne({ email: email });

    if (!user) {
      const hashedPassword = await bcrypt.hash(password, 10);
      user = await User.create({
        email: email,
        pfp: pfp,
        username: username,
        password: hashedPassword,
      });

      user.password = undefined;
      res.json({ user });
    } else {
      return res.json({
        message: "User already exists!",
      });
    }
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const signin = async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const getinfo = async (req, res) => {
  try {
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};
