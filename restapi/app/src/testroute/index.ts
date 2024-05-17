import express from "express";
import { prisma } from "../DBConnections/prisma";
import mysql from "../DBConnections/mysql";


const router = express.Router();

// definisikan semua subroute disini
router.get("/", (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Ini test route'
    res.send("This is test route");
});

router.get("/testdata", async (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Ini test route buat dapetin data'
    const data = await prisma.tes.findMany();
    res.json(data);
});

router.post("/testdata", async (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Ini test route buat nambahin data'
    console.log(req.body)
    const { test_text, test_number }: {
        test_text: string,
        test_number: number | string
    } = req.body;

    const data = await prisma.tes.create({
        data: {
            test_text,
            test_number: BigInt(test_number)
        }
    });
    res.json(data);
});

router.delete("/testdata/:id", async (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Ini test route buat hapus data'
    const id = parseInt(req.params.id);
    const data = await prisma.tes.delete({
        where: {
            id
        }
    });
    res.json(data);
});

router.get("/test2", async (req, res) => {
    // #swagger.tags = ['Test Route']
    res.json({ "foo": "bar" })
})

router.get("/testmysql", async (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Test dapetin semua data auth'
    const result = await mysql.execute("SELECT username, email FROM auth_user;")
    res.json(result[0])

})

router.get("/testmysql2", async (req, res) => {
    // #swagger.tags = ['Test Route']
    // #swagger.description = 'Test dapetin data auth dimana username yang ada kata yang dicari nya. Contoh: username = sendi'
    /* #swagger.parameters['username'] = {
        in: 'query',
        description: 'Username yang ingin dicari',
        type: 'string'
       }
    */
    const { username } = req.query;

    if (!username) return res.status(400).json({ message: "Username is required" });

    const result = await mysql.execute("SELECT username, email FROM auth_user WHERE username LIKE ?;", [`%${username}%`])
    res.json(result[0])

})

export default router;