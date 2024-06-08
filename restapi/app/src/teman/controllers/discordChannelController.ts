import { PrismaClient } from "@prisma/client";
import { Request, Response } from "express";
import mysql from "../../DBConnections/mysql";

const prisma = new PrismaClient();

export const getAllCourses = async (req: Request, res: Response): Promise<Response> => {
    //#swagger.tags = ['Teman']

    try {
        const [results] = await mysql.execute("SELECT id, display_name, course_image_url FROM course_overviews_courseoverview");
        if (Array.isArray(results) && results.length > 0) {  // Check if results is an array and not empty
            return res.json(results);  // Send back all courses
        } else {
            return res.status(404).json({ message: "No courses found" });
        }
    } catch (error) {
        console.error('Error during the database query:', error);
        return res.status(500).json({ message: "Internal server error" });
    }
};

// Controller to handle retrieving course name and course image by course ID
export const getCourseById = async (req: Request, res: Response): Promise<Response> => {
    //#swagger.tags = ['Teman']
    const { id } = req.params;  // Assume the route parameter is named 'courseId'

    if (!id) {
        return res.status(400).json({ message: "Course ID is required" });
    }

    try {
        // Query to select the display_name and course_image_url from course table where the id matches
        const [results] = await mysql.execute("SELECT display_name, course_image_url FROM course_overviews_courseoverview WHERE id = ?", [id]);
        if (Array.isArray(results) && results.length > 0) {
            return res.json(results);  // Send back the course details
        } else {
            return res.status(404).json({ message: "Course not found" });
        }
    } catch (error) {
        console.error('Error during the database query:', error);
        return res.status(500).json({ message: "Internal server error" });
    }
};

export const createDiscordChannel = async (req: Request, res: Response) => {
    // #swagger.tags = ['Teman']
    // #swagger.description = 'untuk menambahkan discord channel baru'
    const { user_id, course_id, server_id, channel_id, channel_name, channel_image_url} = req.body;

    try {
        const newChannel = await prisma.discord_channels.create({
            data: {
                user_id,
                course_id,
                server_id,
                channel_id,
                channel_name,
                channel_image_url,
            },
        });
        res.status(201).json(newChannel);
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};

export const getAllDiscordChannels = async (req: Request, res: Response) => {
    // #swagger.tags = ['Teman']
    // #swagger.description = 'untuk mendapatkan semua discord channel'
    try {
        const channels = await prisma.discord_channels.findMany();
        res.status(200).json(channels);
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};

export const getDiscordChannelById = async (req: Request, res: Response) => {
    // #swagger.tags = ['Teman']
    // #swagger.description = 'untuk mendapatkan satu discord channel berdasarkan id'
    const { id } = req.params;
    try {
        const channel = await prisma.discord_channels.findUnique({
            where: { id: Number(id) },
        });
        if (channel) {
            res.status(200).json(channel);
        } else {
            res.status(404).json({ msg: "Channel not found" });
        }
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};

export const updateDiscordChannel = async (req: Request, res: Response) => {
    // #swagger.tags = ['Teman']
    // #swagger.description = 'untuk memperbarui satu discord channel berdasarkan id'
    const { id } = req.params;
    const { server_id, course_id, channel_id, channel_name, channel_image_url} = req.body;

    try {
        const updatedChannel = await prisma.discord_channels.update({
            where: { id: Number(id) },
            data: {
                course_id,
                server_id,
                channel_id,
                channel_name,
                channel_image_url,
            },
        });
        res.status(200).json(updatedChannel);
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};

export const deleteDiscordChannel = async (req: Request, res: Response) => {
    // #swagger.tags = ['Teman']
    // #swagger.description = 'untuk menhapus satu discord channel berdasarkan id'
    const { id } = req.params;

    try {
        await prisma.discord_channels.delete({
            where: { id: Number(id) },
        });
        res.status(200).json({ msg: "Channel successfully deleted" });
    } catch (error) {
        res.status(500).json({ msg: (error as Error).message });
    }
};
