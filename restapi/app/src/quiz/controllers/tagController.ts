import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";

const prisma = new PrismaClient();

export const getAllTags = async (req: Request, res: Response) => {
    // #swagger.tags = ['Tag']
    // #swagger.description = 'API to get all tags that have quiz'
    try {
        const response = await prisma.tag.findMany({
            where: {
                quiz: {
                    some: {},
                },
            }
        });
        res.status(200).json(response);
    } catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ msg: error.message });
        } else {
            res.status(500).json({ msg: "An unknown error occurred" });
        }
    }
};

export const getTagsByUserId = async (req: Request, res: Response) => {
    // #swagger.tags = ['Tag']
    // #swagger.description = 'API to get all tags that have quiz by userId'
    const { userId } = req.params;
    try {
        const quizzes = await prisma.quiz.findMany({
            where: {
                userId: parseInt(userId),
            },
            include: {
                tags: {
                    select: {
                        id: true,
                        nama_tag: true
                    }
                }
            }
        });

        if (quizzes.length === 0) {
            return res.status(404).json({ msg: "No quizzes found for this user" });
        }

        const tags = quizzes.flatMap(quiz => quiz.tags);

        res.status(200).json(tags);
    } catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ msg: error.message });
        } else {
            res.status(500).json({ msg: "An unknown error occurred" });
        }
    }
};