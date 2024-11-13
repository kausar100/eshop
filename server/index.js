const express = require('express');
const cors = require('cors');
const { getMessaging } = require("firebase-admin/messaging");

var admin = require("firebase-admin");
var serviceAccount = require("./service_account_key.json");
// $env:GOOGLE_APPLICATION_CREDENTIALS="D:\android_studio\ecommerce_shop\server\service_account_key.json"
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const app = express();
app.use(express.json());
app.use(cors());

app.get('/', (req, res) => {
    res.end('Welcome');
});

app.post('/notify', (req, res) => {

    // This registration token comes from the client FCM SDKs.
    const registrationToken = req.query.token;

    console.log(`fcm token : ${registrationToken}`);

    const message = {
        notification: {
            title: "Breaking News",
            body: "New news story available."
        },
        token: registrationToken
    };

    // Send a message to the device corresponding to the provided registration token.
    getMessaging().send(message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
            res.status(200).json({
                message: 'Successfully sent message',
                token: registrationToken
            });
        })
        .catch((error) => {
            console.log('Error sending message:', error);
            res.status(400).json(error);
        });
});

app.listen(3000, () => console.log(`server started at http://localhost:3000`));