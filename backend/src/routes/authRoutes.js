import express from 'express';
import { authenticate } from '../middlewares/authMiddleware.js';
import { signup, signin, getinfo } from '../controllers/authController.js';

export const router = express.Router();

router.post('/signup', signup);
router.post('/signin', signin);
router.get('/me', authenticate, getinfo);