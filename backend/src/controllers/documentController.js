export const createDocument = async (req, res) => {
  try {
    const document = await Document.create({
      uid: req.user,
      title: 'Untitled Document',
      createdAt: new Date(),
    });
    res.json(document);
  } catch {
    return res.status(500).json({
      message: "Something went wrong",
    });
  }
};