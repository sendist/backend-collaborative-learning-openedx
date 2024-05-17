import express from "express";
const router = express.Router();
// untuk masing-masing fitur, buat folder sesuai fitur pada folder "src", misal "forumdiskusi"
// dapat melakukan copy file index.ts dari testroute sebagai template awal pembuatan route API
// setelah membuat route, masukkan import di sini.
// Mohon samakan format penamaan default import dengan menambahkan "Route" pada akhir nama, misal:
// import forumdiskusiRoute from "./forumdiskusi";
import testRoute from "./testroute";
import temanRoute from "./teman"
import discussionRoute from "./discussion";
import quizRoute from "./quiz";
import catatanBelajarRoute from "./catatanBelajar";


// untuk masing-masing fitur, tambahkan route di sini. contoh:
// router.use("/forumdiskusi", forumdiskusiRoute);
router.use('/test', testRoute);

router.use('/discussion', discussionRoute);
router.use('/quiz', quizRoute);
router.use('/teman', temanRoute);
router.use("/catatanBelajar", catatanBelajarRoute);

export default router;