import mongoose from "mongoose";

const documentSchema = new mongoose.Schema({
    uid: {
        required: true,
        type: String,
    },
    createdAt: {
        required: true,
        type: Date,
    },
    title: {
        required: true,
        type: String,
        trim: true,
    },
    content: {
        type: Array,
        default: [],
    }
});

export const Document = mongoose.model('Document', documentSchema);