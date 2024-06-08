import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import cloudinary from "../config/cloudinaryConfig";
import mysql from "../../DBConnections/mysql";

const prisma = new PrismaClient();
export const getQuiz = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for get all list quiz or filter by tag'
    try {
        const { tag } = req.query;
        let response;

        // Jika tag ada, maka filter berdasarkan tag
        if (typeof tag === 'string') {
            response = await prisma.quiz.findMany({
                where: {
                    tags: {
                        some: {
                            nama_tag: tag,
                        },
                    },
                },
                orderBy: {
                    id: 'desc',
                },
                include: {
                    tags: true,
                },
            });
        } else {
            response = await prisma.quiz.findMany({
                orderBy: {
                    id: 'desc', // Mengurutkan berdasarkan id secara descending
                },
                include: {
                    tags: true,
                },
            });
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};

export const createQuiz = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for create new quiz'
    try {
        const { title, jumlahSoal, link, userId, tags } = req.body;
        const image = req.file ? req.file.path : null;

        if (!title || !jumlahSoal || !link || userId === 0) {
            return res.status(400).json({ msg: "Semua informasi harus diisi" });
        }

        const existingQuiz = await prisma.quiz.findFirst({
            where: { title }
        });

        if (existingQuiz) {
            return res.status(400).json({ msg: "Quiz dengan judul yang sama sudah ada" });
        }

        const quizizzUrlRegex = /^(https?:\/\/)?(www\.)?quizizz\.com\/.+/;
        if (!quizizzUrlRegex.test(link)) {
            return res.status(400).json({ msg: "Link harus berupa link dari Quizizz" });
        }

        // Upload gambar ke Cloudinary
        let cloudinaryImage;
        if (image) {
            cloudinaryImage = await cloudinary.uploader.upload(image);
        }

        const tagsArray = Array.isArray(tags) ? tags : [];

        const newQuiz = await prisma.quiz.create({
            data: {
                title,
                jumlahSoal: parseInt(jumlahSoal),
                link,
                image: cloudinaryImage ? cloudinaryImage.secure_url : null,
                userId: parseInt(userId),
                tags: {
                    connectOrCreate: tagsArray.map((tag) => ({
                        where: { nama_tag: tag.nama_tag },
                        create: { nama_tag: tag.nama_tag },
                    })),
                },
            },

            include: {
                tags: true,
            },
        });
        console.log("quiz: ", newQuiz);

        return res.status(201).json({
            msg: "Berhasil membuat quiz baru",
            data: {
                id: newQuiz.id,
                title: newQuiz.title,
                jumlahSoal: newQuiz.jumlahSoal,
                link: newQuiz.link,
                image: newQuiz.image,
                user: newQuiz.userId,
                tags: newQuiz.tags,
            },
        });
    } catch (error) {
        console.log(error);
        return res
            .status(500)
            .json({ msg: "Terjadi kesalahan saat membuat quiz baru" });
    }
};

export const editQuiz = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for edit quiz'
    try {
        const quizId = parseInt(req.params.quizId, 10);
        const { title, jumlahSoal, link, userId, tags } = req.body;

        if (!title || !jumlahSoal || !link || !userId) {
            return res.status(400).json({ msg: 'Semua field harus diisi' });
        }

        const existingTitle = await prisma.quiz.findFirst({
            where: {
                id: { not: quizId },
                title: title
            }
        });

        if (existingTitle) {
            return res.status(400).json({ msg: 'Quiz dengan judul yang sama sudah ada' });
        }

        const tagsArray = Array.isArray(tags) ? tags : [];

        const existingQuiz = await prisma.quiz.findUnique({
            where: { id: quizId },
            include: { tags: true },
        });

        if (!existingQuiz) {
            return res.status(404).json({ msg: 'Quiz tidak ditemukan' });
        }

        const quizizzUrlRegex = /^(https?:\/\/)?(www\.)?quizizz\.com\/.+/;
        if (!quizizzUrlRegex.test(link)) {
            return res.status(400).json({ msg: "Link harus berupa link dari Quizizz" });
        }

        const image = req.file ? req.file.path : existingQuiz.image;

        // Upload gambar ke Cloudinary
        let cloudinaryImage;
        if (image) {
            cloudinaryImage = await cloudinary.uploader.upload(image);
        }

        // Process the tags to connect or create
        const updatedTags = tagsArray.map(tag => ({
            where: { nama_tag: tag.nama_tag }, // Use `nama_tag` as the selection criterion
            create: { nama_tag: tag.nama_tag } // Create new tag if not found
        }));

        // Find tags to disconnect (remove)
        const tagsToDisconnect = existingQuiz.tags.filter(existingTag =>
            !tagsArray.some(newTag => newTag.nama_tag === existingTag.nama_tag)
        );

        const updatedQuiz = await prisma.quiz.update({
            where: { id: quizId },
            data: {
                title,
                jumlahSoal: parseInt(jumlahSoal),
                link,
                image: cloudinaryImage ? cloudinaryImage.secure_url : null,
                userId: parseInt(userId),
                tags: {
                    connectOrCreate: updatedTags,
                    disconnect: tagsToDisconnect.map(tag => ({ id: tag.id })),
                }
            },
            include: {
                tags: true
            }
        });

        return res.status(200).json({
            msg: 'Berhasil mengedit quiz',
            data: {
                id: updatedQuiz.id,
                title: updatedQuiz.title,
                jumlahSoal: updatedQuiz.jumlahSoal,
                link: updatedQuiz.link,
                image: updatedQuiz.image,
                user: updatedQuiz.userId,
                tags: updatedQuiz.tags
            }
        });

    } catch (error) {
        console.log(error);
        return res.status(500).json({ msg: 'Terjadi kesalahan saat mengedit quiz' });
    }
};

export const getQuizById = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for get detail quiz by id'
    try {
        const { id } = req.params;

        if (!id) {
            return res.status(400).json({ msg: "ID quiz harus diisi" });
        }

        const quiz = await prisma.quiz.findUnique({
            where: {
                id: parseInt(id),
            },
            include: {
                tags: true,
            },
        });

        if (!quiz) {
            return res.status(404).json({ msg: "Quiz tidak ditemukan" });
        }

        res.status(200).json(quiz);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ msg: "Terjadi kesalahan saat mengambil quiz" });
    }
};

export const getQuizByUser = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for get list quiz by user'
    const userId = req.params.userId;
    const search = typeof req.query.search === 'string' ? req.query.search.trim() : undefined;
    try {
        let response;

        if (search) {
            response = await prisma.quiz.findMany({
                where: {
                    userId: Number(userId),
                    OR: [
                        {
                            title: {
                                contains: search,
                                mode: 'insensitive', // Case-insensitive search
                            },
                        },
                        {
                            tags: {
                                some: {
                                    nama_tag: {
                                        contains: search,
                                        mode: 'insensitive', // Case-insensitive search
                                    },
                                },
                            },
                        },
                    ],
                },
                orderBy: {
                    id: 'desc',
                },
                include: {
                    tags: true,
                },
            });
        } else {
            response = await prisma.quiz.findMany({
                where: {
                    userId: Number(userId),
                },
                orderBy: {
                    id: 'desc',
                },
                include: {
                    tags: true,
                },
            });
        }

        res.status(200).json(response);
    } catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ msg: error.message });
        } else {
            res.status(500).json({ msg: "An unknown error occurred" });
        }
    }
};

export const deleteQuiz = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for delete quiz'
    try {
        const { id } = req.params;

        if (!id) {
            return res.status(400).json({ msg: "ID quiz harus diisi" });
        }

        const deletedQuiz = await prisma.quiz.delete({
            where: {
                id: parseInt(id),
            },
            include: {
                tags: true,
            },
        });

        return res.status(200).json({
            msg: `Berhasil menghapus quiz ${deletedQuiz.title}`,
        });
    } catch (error) {
        console.log(error);
        return res
            .status(500)
            .json({ msg: "Terjadi kesalahan saat menghapus quiz" });
    }
};

export const reportQuiz = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for reporting quiz'
    const { user_id, quiz_id, report_type } = req.body;

    if (!user_id || !quiz_id || !report_type) {
        return res.status(400).json({ msg: "Missing required fields" });
    }

    try {
        // Cek apakah sudah ada laporan dengan user_id dan quiz_id yang sama
        const existingReport = await prisma.report.findFirst({
            where: {
                user_id,
                quiz_id: parseInt(quiz_id),
            }
        });

        if (existingReport) {
            return res.status(409).json({ msg: "Anda sudah melaporkan quiz ini" });
        }

        await prisma.report.create({
            data: {
                user_id,
                quiz_id: parseInt(quiz_id),
                report_type,
            }
        });

        return res.status(201).json({
            msg: `Berhasil melaporkan quiz`,
        });
    } catch (error) {
        console.log(error);
        return res
            .status(500)
            .json({ msg: "Terjadi kesalahan saat menghapus quiz" });
    }
}

export const listQuizReports = async (req: Request, res: Response) => {
    // #swagger.tags = ['Quiz']
    // #swagger.description = 'API for get list data quiz report'
    try {
        const reports = await prisma.report.findMany({
            include: {
                quiz: true,
            }
        });

        const transformedReports = reports.map(report => ({
            report_id: report.id,
            user_id: parseInt(report.user_id),
            quiz_title: report.quiz?.title,
            quiz_id: report.quiz_id,
            report_type: report.report_type,
            created_at: report.created_at,
            status_review: report.status_review
        }));

        return res.status(200).json(transformedReports);
    } catch (error) {
        console.log(error);
        return res.status(500).json({ msg: "Terjadi kesalahan saat mengambil data laporan" });
    }
};