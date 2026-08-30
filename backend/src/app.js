import express from 'express';
import cors from "cors";
import { router as authRouter } from './routes/authRoutes.js';
import { router as documentRouter } from './routes/documentRoutes.js';

export const app = express();

app.use(cors());
app.use(express.json());
app.use('/', authRouter);
app.use('/', documentRouter);