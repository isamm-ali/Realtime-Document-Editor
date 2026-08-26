import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        lowercase: true,
        unique: true,
        trim: true
    },
    password: {
        type: String,
        required: true,
    },
    pfp: {
        type: String,
        required: true,
        trim: true
    }
});

export const User = mongoose.model("User", userSchema);