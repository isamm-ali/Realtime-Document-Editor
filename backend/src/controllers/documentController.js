import { Document } from "../models/document.js";

export const createDocument = async (req, res) => {
  try {
    const document = await Document.create({
      uid: req.user.userId,
      title: 'Untitled Document',
      createdAt: new Date(),
    });
    res.status(200).json(document);
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const getDocuments = async (req, res) => {
  try {
    let documents = await Document.find({uid: req.user.userId});
    res.json(documents);
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};