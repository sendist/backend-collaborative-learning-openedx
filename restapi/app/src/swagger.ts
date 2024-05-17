import swaggerAutogen from 'swagger-autogen';

const doc = {
    info: {
        version: 'v1.0.0',
        title: 'SakauBelajar',
        description: 'Dokumentasi API SakauBelajar',
    },
    servers: [
        {
            url: 'http://194.233.93.124:3030',
            description: 'kalau akses pake IP'
        },
        {
            url: 'http://localhost:3030',
            description: 'kalau akses pake forward port (localhost)'
        }
    ],
    components: {
        // securitySchemes: {
        //     bearerAuth: {
        //         type: 'http',
        //         scheme: 'bearer',
        //     }
        // }
    }
};

const outputFile = './swagger_output.json';
const endpointsFiles = ['./src/index.ts'];

swaggerAutogen({ openapi: '3.1.0' })(outputFile, endpointsFiles, doc);