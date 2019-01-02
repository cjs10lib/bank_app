const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);


exports.welcomeMessage = functions.firestore
    .document('account/{accountId}')
    .onCreate((snapshot, context) => {
        var msgData = 'Thank you for signing up. We will review your credentials and notify you on approval.'
        
        admin.firestore().collection('pushtokens').doc(snapshot.id).get().then((snapshots) => {
            var token;
            if (snapshots.exists) {
                token = snapshots.data().token;
            } else {
                console.log('No device token found!');
            }

            var payload = {
                "notification": {
                    "title": "KAMCCU CORP CREDIT UNION",
                    "body": msgData,
                    "notification": "default"
                },
                "data": {
                    "sendername": "KAMCCU CORP CREDIT UNION",
                    "message": msgData
                }
            }

            return admin.messaging().sendToDevice(token, payload).then((response) => {
                console.log('Pushed message');
            }).catch((error) => console.log(error));
        })
    })