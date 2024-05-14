import { Router } from "express";
import { todoController } from "../controllers/controller.js";

const router = Router();

router.get("/", todoController.getAll);

export default router;