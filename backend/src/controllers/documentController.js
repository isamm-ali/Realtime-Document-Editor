import { Document } from "../models/document.js";

export const createDocument = async (req, res) => {
  try {
    const document = await Document.create({
      uid: req.user.userId,
      title: "Untitled Document",
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
    let document = await Document.find({ uid: req.user.userId });
    res.json(document);
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const getDocument = async (req, res) => {
  try {
    const document = await Document.findOne({ _id: req.params.id, uid: req.user.userId });
    res.json(document);
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};

export const nameDocument = async (req, res) => {
  try {
    const { id, title } = req.body;
    const document = await Document.findOneAndUpdate(
      {_id: id, uid: req.user.userId,},
      {title,},
      {new: true,},
    );
    if (!document) {
      return res.status(404).json({
        message: "Document not found",
      });
    }
    res.status(200).json(document);
  } catch (error) {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};
