import express from "express";
import { upload } from "./middleware/multer";

import { getQuiz, createQuiz, editQuiz, getQuizById, getQuizByUser, deleteQuiz, reportQuiz, listQuizReports } from "./controllers/quizController";
import { getAllTags, getTagsByUserId } from "./controllers/tagController";

const router = express.Router();

router.get("/quizzes", getQuiz);
router.post("/new-quiz", upload.single("image"), createQuiz);
router.put('/edit-quiz/:quizId', upload.single('image'), editQuiz);
router.get("/quizzes/:id", getQuizById);
router.get("/quizzes/user/:userId", getQuizByUser);
router.delete("/quiz/:id", deleteQuiz);

router.get("/tags", getAllTags);
router.get("/tags/user/:userId", getTagsByUserId);

router.post("/report", reportQuiz);
router.get("/report/list", listQuizReports);
export default router;
