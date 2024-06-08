import { Request, Response } from 'express';
import mysql from "../../DBConnections/mysql";
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();


export const followFriend = async (req: Request, res: Response): Promise<Response> => {
  //#swagger.tags = ['Teman']
  try {
    if (!req.body.username1 || !req.body.username2) {
      return res
        .status(400)
        .json({ error: "Both username1 and username2 are required" });
    }
    console.log("Username1:", req.body.username1); // Debug log
    console.log("Username2:", req.body.username2); // Debug log


    // Fetch user IDs for the provided usernames
    const [results1]: [any[], any] = await mysql.execute(
      "SELECT id FROM auth_user WHERE BINARY username = ?",
      [req.body.username1]
    );
    const [results2]: [any[], any] = await mysql.execute(
      "SELECT id FROM auth_user WHERE BINARY username = ?",
      [req.body.username2]
    );


    if (results1.length === 0 || results2.length === 0) {
      return res.status(404).json({ error: "One or both users not found" });
    }

    const userId1 = parseInt(results1[0].id, 10);
    const userId2 = parseInt(results2[0].id, 10);

    // Check if the follow relationship already exists in both directions
    const existingFollow1 = await prisma.follow_teman.findUnique({
      where: {
        id_akun1_id_akun2: {
          id_akun1: userId1,
          id_akun2: userId2,
        },
      },
    });

    const existingFollow2 = await prisma.follow_teman.findUnique({
      where: {
        id_akun1_id_akun2: {
          id_akun1: userId2,
          id_akun2: userId1,
        },
      },
    });

    if (existingFollow1 && existingFollow2) {
      // Toggle the existing follow state
      const updatedFollow1 = await prisma.follow_teman.update({
        where: {
          id_follow: existingFollow1.id_follow,
        },
        data: {
          is_follow: !existingFollow1.is_follow,
        },
      });

      const updatedFollow2 = await prisma.follow_teman.update({
        where: {
          id_follow: existingFollow2.id_follow,
        },
        data: {
          is_follow: !existingFollow2.is_follow,
        },
      });

      return res.status(200).json({
        message: "Follow state toggled",
        follow: [updatedFollow1, updatedFollow2],
      });
    } else if (existingFollow1 && !existingFollow2) {
      // Update the existing follow relationship with the opposite state
      const updatedFollow = await prisma.follow_teman.update({
        where: {
          id_follow: existingFollow1.id_follow,
        },
        data: {
          is_follow: !existingFollow1.is_follow,
        },
      });

      return res.status(200).json({
        message: "Follow state updated",
        follow: updatedFollow,
      });
    } else if (!existingFollow1 && existingFollow2) {
      // Update the existing follow relationship with the opposite state
      const updatedFollow = await prisma.follow_teman.update({
        where: {
          id_follow: existingFollow2.id_follow,
        },
        data: {
          is_follow: !existingFollow2.is_follow,
        },
      });

      return res.status(200).json({
        message: "Follow state updated",
        follow: updatedFollow,
      });
    } else {
      // Create a new follow relationship
      const newFollow = await prisma.follow_teman.create({
        data: {
          id_akun1: userId1,
          id_akun2: userId2,
          is_follow: true,
        },
      });

      return res.status(201).json({ message: "Follow relationship created", follow: newFollow });
    }
  } catch (error) {
    console.error("Error handling follow:", error);
    return res.status(500).json({ error: "An error occurred during the operation" });
  }
};

export const findUserByUsernameOrName = async (
  req: Request,
  res: Response
): Promise<Response> => {
  //#swagger.tags = ['Teman']
  const { keyword } = req.query as { keyword?: string };

  if (!keyword) {
    return res
      .status(400)
      .json({ error: "Keyword is required for the search" });
  }

  try {
    // Search in auth_user table by username
    const queryUser =
      "SELECT * FROM auth_user WHERE username LIKE CONCAT('%', ?, '%')";
    const [userResults] = (await mysql.execute(queryUser, [keyword])) as [
      any[],
      any
    ];

    // Search in auth_userprofile table by name
    const queryUserProfile =
      "SELECT * FROM auth_userprofile WHERE name LIKE CONCAT('%', ?, '%')";
    const [profileResults] = (await mysql.execute(queryUserProfile, [
      keyword,
    ])) as [any[], any];

    // Combine user and profile results
    const combinedResults = userResults.map((user) => {
      const userProfile = profileResults.find(
        (profile) => profile.user_id === user.id
      );
      const combined = {
        ...user,
        ...userProfile,
        is_follow: false, // Assume false for simplicity; update based on actual follow status
      };
      delete combined.password; // Remove sensitive data
      return combined;
    });

    if (combinedResults.length > 0) {
      return res.status(200).json(combinedResults);
    } else {
      return res
        .status(404)
        .json({ error: "No matching users or profiles found" });
    }
  } catch (error) {
    console.error("Error during the database queries:", error);
    return res.status(500).json({ error: "Internal server error" });
  }
};


export const getAllUsersWithFollow = async (
  req: Request,
  res: Response
): Promise<Response> => {
  //#swagger.tags = ['Teman']
  try {
    // Fetch user ID based on username from MySQL
    const userIdQuery = "SELECT id FROM auth_user WHERE BINARY username = ?";
    const [user] = (await mysql.execute(userIdQuery, [
      req.params.username,
    ])) as [any[], any];

    if (!user.length) {
      return res.status(404).json({ error: "User not found" });
    }

    const userId = user[0].id;

    // Fetch all users from MySQL
    const query =
      "SELECT auth_userprofile.*, auth_user.username FROM auth_userprofile JOIN auth_user ON auth_user.id = auth_userprofile.user_id WHERE auth_user.id != ?";
    const [users] = (await mysql.execute(query, [userId])) as [any[], any];

    if (!users.length) {
      return res.status(404).json({ error: "No users found" });
    }

    // Fetch all follow relationships from PostgreSQL that involve the requesting user
    const follows = await prisma.follow_teman.findMany({
      where: {
        OR: [{ id_akun1: userId }, { id_akun2: userId }],
      },
      select: {
        id_akun1: true,
        id_akun2: true,
        is_follow: true,
      },
    });

    // Map each user to include follow details
    const usersWithFollows = users.map((user) => {
      const follow = follows.find(
        (f) =>
          (f.id_akun1 === userId && f.id_akun2 === user.user_id) ||
          (f.id_akun1 === user.user_id && f.id_akun2 === userId)
      );
      const is_follow = follow ? follow.is_follow : false;
      return {
        ...user,
        is_follow,
      };
    });

    return res.status(200).json(usersWithFollows);
  } catch (error) {
    console.error("Error during the database query:", error);
    return res.status(500).json({ error: "Internal server error" });
  }
};


interface User {
  id: number;
  username: string;
  // Include other relevant fields
}

interface FollowRelation {
  id_akun1: number;
  id_akun2: number;
  is_follow: boolean;
}

interface FriendDetails extends User {
  is_follow: boolean;
}
