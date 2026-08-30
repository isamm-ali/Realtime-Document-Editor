import express from 'express';
import { router as authRouter } from './routes/authRoutes.js';
import { router as documentRouter } from './routes/documentRoutes.js';

export const app = express();

app.use(express.json());
app.use('/', authRouter);
app.use('/', documentRouter);