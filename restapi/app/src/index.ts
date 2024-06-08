import express, { Express } from "express";
import "./serializationfix.js"
import swaggerUi from "swagger-ui-express";
import swaggerOutput from "./swagger_output.json";
import dotenv from "dotenv";
import routes from "./routes";
import cors from "cors";
import bodyParser from "body-parser";
dotenv.config();

const app: Express = express();
const port = 3030;

app.use(cors())
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.text({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '50mb' }));


app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerOutput, {
    explorer: true
}));
app.use(routes);


app.listen(port, () => {
    console.log(`[server]: Server is running at http://localhost:${port}`);
});