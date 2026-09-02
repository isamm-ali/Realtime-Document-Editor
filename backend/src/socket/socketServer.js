import { Document } from "../models/document.js";

const saveData = async (data) => {
  try {
    if (!data.documentId || !data.delta) {
      console.log("Invalid save data");
      return;
    }

    const document = await Document.findByIdAndUpdate(
      data.documentId,
      {
        $set: {
          content: data.delta,
        },
      },
      {
        new: true,
        runValidators: true,
      },
    );

    if (!document) {
      console.log("Document not found:", data.documentId);
      return;
    }

    console.log("Document saved:", data.documentId);
  } catch (error) {
    console.error("Save error:", error);
  }
};

export const socketServer = (io) => {
  io.on("connection", (socket) => {
    console.log("User connected:", socket.id);

    socket.on("join", (documentId) => {
      if (!documentId) return;

      socket.join(documentId);

      console.log(`${socket.id} joined room ${documentId}`);
    });

    socket.on("typing", (data) => {
      if (!data?.room || !data?.delta) {
        return;
      }

      console.log(`${socket.id} typing in room ${data.room}`);

      socket.broadcast.to(data.room).emit("changes", data);
    });

    socket.on("save", async (data) => {
      await saveData(data);
    });

    socket.on("disconnect", (reason) => {
      console.log(`User disconnected: ${socket.id} - ${reason}`);
    });
  });
};
