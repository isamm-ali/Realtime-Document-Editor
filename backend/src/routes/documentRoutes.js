import express from 'express';
import { authenticate } from '../middlewares/authMiddleware.js';
import { createDocument, getDocuments } from '../controllers/documentController.js';

export const router = express.Router();

router.post('/doc/create', authenticate, createDocument);
router.get('doc/me', authenticate, getDocuments);