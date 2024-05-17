import express from "express";
import { followFriend, getAllUsersWithFollow, findUserByUsernameOrName } from "./controllers/temanController";
import { createDiscordChannel, getAllDiscordChannels, getDiscordChannelById, updateDiscordChannel, deleteDiscordChannel, getAllCourses, getCourseById} from './controllers/discordChannelController';
import { getUserFriendsCourses } from "./controllers/timelineController";

const router = express.Router();

router.post('/follow', express.json(), followFriend); 
router.get('/searchUser', findUserByUsernameOrName);
router.get('/friend-users/:username', getAllUsersWithFollow);

router.get("/friends-timeline/:username", getUserFriendsCourses);

// Discord Channels Route
router.post('/discordChannels', createDiscordChannel);
router.get('/discordChannels', getAllDiscordChannels);
router.get('/discordChannels/:id', getDiscordChannelById);
router.patch('/discordChannels/:id', updateDiscordChannel);
router.delete('/discordChannels/:id', deleteDiscordChannel);

// Course Controller
router.get('/courses', getAllCourses);
router.get('/courses/:id', getCourseById);







export default router;