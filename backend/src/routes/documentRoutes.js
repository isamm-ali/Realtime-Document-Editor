import express from 'express';
import { authenticate } from '../middlewares/authMiddleware.js';
import { createDocument } from '../controllers/documentController.js';

export const router = express.Router();

router.post('/doc/create', authenticate, createDocument);