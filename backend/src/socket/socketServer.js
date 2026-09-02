import { Document } from "../models/document.js";

const saveData = async (data) => {
  let document = await Document.findById(data.documentId);
  document.content = data.delta;
  document = await document.save();
}

export const socketServer = (io) => {
  io.on("connection", (socket) => {
    console.log("User connected:", socket.id);

    socket.on("join", (documentId) => {
      socket.join(documentId);
      console.log(`${socket.id} joined room ${documentId}`);
    });

    socket.on("typing", (data) => {
      socket.broadcast
        .to(data.room)
        .emit("changes", data);
    });

    socket.on('save', (data) => {
      saveData(data);
    });

    socket.on("disconnect", () => {
      console.log("User disconnected:", socket.id);
    });
  });
};

