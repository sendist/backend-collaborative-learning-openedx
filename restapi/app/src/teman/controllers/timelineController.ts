import { Request, Response } from "express";
import mysql from "../../DBConnections/mysql";
import { PrismaClient } from "@prisma/client";
import { RowDataPacket } from "mysql2";

const prisma = new PrismaClient();

export const getUserFriendsCourses = async (
  req: Request,
  res: Response
): Promise<Response> => {
  const { username } = req.params;

  if (!username) {
    return res.status(400).json({ error: "Username parameter is required" });
  }

  try {
    // Retrieve User ID from the username
    const [users, _]: [RowDataPacket[], any] = await mysql.execute(
      "SELECT id FROM auth_user WHERE username = ?",
      [username]
    );

    if (users.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const userId = users[0].id;
    // Retrieve follow relationships from PostgreSQL using Prisma
    const follows = await prisma.follow_teman.findMany({
      where: {
        OR: [{ id_akun1: userId }, { id_akun2: userId }],
        is_follow: true,
      },
    });

    if (follows.length === 0) {
      return res.status(404).json({ error: "No friends found for the user" });
    }

    const friendIds = follows.map((follow) =>
      follow.id_akun1 === userId ? follow.id_akun2 : follow.id_akun1
    );

    // Fetch friend details and their courses from MySQL
    const friendsCourses = await Promise.all(
      friendIds.map(async (friendId) => {
        const [friendProfiles, __]: [RowDataPacket[], any] =
          await mysql.execute(
            `SELECT u.id, u.username, p.meta FROM auth_user u JOIN auth_userprofile p ON u.id = p.user_id WHERE u.id = ?`,
            [friendId]
          );

        const friendProfile = friendProfiles[0];

        const [courses, ___]: [RowDataPacket[], any] = await mysql.execute(
          `SELECT c.display_name, s.created FROM student_courseenrollment_history s JOIN course_overviews_courseoverview c ON s.course_id = c.id WHERE s.user_id = ?`,
          [friendId]
        );

        return {
          friend_id: friendProfile.id,
          friend_username: friendProfile.username,
          friend_meta: friendProfile.meta,
          courses: courses.map((course: any) => ({
            course_id: course.course_id,
            course_name: course.display_name,
            enrollment_date: course.created, // Added 'created' date as 'enrollment_date'
          })),
        };
      })
    );

    return res.json({ friendsCourses });
  } catch (error) {
    console.error("Database or server error:", error);
    return res.status(500).json({ error: "Internal server error" });
  }
};
