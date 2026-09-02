import express from 'express';
import { authenticate } from '../middlewares/authMiddleware.js';
import { createDocument, getDocuments, getDocument, nameDocument } from '../controllers/documentController.js';

export const router = express.Router();

router.post('/doc/create', authenticate, createDocument);
router.get('/doc/me', authenticate, getDocuments);
router.get('/doc/:id', authenticate, getDocument);
router.post('/doc/name', authenticate, nameDocument);
