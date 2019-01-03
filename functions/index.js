const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

exports.welcomeMessage = functions.firestore.document('account/{accountId}').onCreate((snapshot, context) => {
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
                "title": "Account Pending Activation!",
                "body": msgData,
                "notification": "default"
            },
            "data": {
                "sendername": "KAMCCU CORP CREDIT UNION",
                "message": msgData
            }
        }

        return admin.messaging().sendToDevice(token, payload).then((response) => {
            console.log('Pushed welcome message');
        }).catch((error) => console.log(error));
    });
});

exports.onAccountActivation = functions.firestore.document('account/{accountId}').onUpdate((change, context) => {
    var msgData;

    var newData = change.after.data();
    var uid = newData.uid;
    console.log('Account Activation running' + uid);

    if (!newData.isActivated) {
        console.log('Account is not activated' + newData.isActivated);
        return null;
    } else {

        //  get account profile
        return admin.firestore().collection('people').doc(uid).get().then((snapshots) => {
            var profile = snapshots.data();
            console.log('Profile Name' + profile.firstname);
            msgData = `Hello ${profile.firstname}. Your account has been successfully activated. Login now to explore your account dashboard`;

            admin.firestore().collection('pushtokens').doc(uid).get().then((snapshots) => {
                var token;
                if (snapshots.exists) {
                    console.log('token exists!');
                    token = snapshots.data().token;
                } else {
                    console.log('No device token found!');
                }

                var payload = {
                    "notification": {
                        "title": "Account Activated!",
                        "body": msgData,
                        "notification": "default"
                    },
                    "data": {
                        "sendername": "KAMCCU CORP CREDIT UNION",
                        "message": msgData
                    }
                }

                return admin.messaging().sendToDevice(token, payload).then((response) => {
                    console.log('Pushed account activated message');
                }).catch((error) => console.log(error));

            }).catch((error) => console.log(error));
        }).catch((error) => console.log(error));

    }

});

exports.onLoanRequest = functions.firestore.document('wallets/{walletsId}/transactions/{transactionId}').onCreate((snapshot, context) => {
    const transactionId = snapshot.id;
    const transaction = snapshot.data();
    const uid = transaction.uid;

    // copy transaction to transactions collection
    return admin.firestore().collection('transactions').doc(transactionId).set(transaction).then((_) => {

        console.log('Copied transactions!');
        console.log(`Current auth uid ${uid}`);

        //  get account profile
        return admin.firestore().collection('people').doc(uid).get().then((snapshots) => {
            var profile = snapshots.data();
            console.log('Profile Name' + profile.firstname);
            msgData = `Hello ${profile.firstname}, we have recieved your loan request for GHC${transaction.amount}. We will notify you on loan approval. Thanks`;

            admin.firestore().collection('pushtokens').doc(uid).get().then((snapshots) => {
                var token;
                if (snapshots.exists) {
                    console.log('token exists!');
                    token = snapshots.data().token;
                } else {
                    console.log('No device token found!');
                }

                var payload = {
                    "notification": {
                        "title": "Loan Application!",
                        "body": msgData,
                        "notification": "default"
                    },
                    "data": {
                        "sendername": "KAMCCU CORP CREDIT UNION",
                        "message": msgData
                    }
                }

                return admin.messaging().sendToDevice(token, payload).then((response) => {
                    console.log('Pushed account activated message');
                }).catch((error) => console.log(error));

            }).catch((error) => console.log(error));
        }).catch((error) => console.log(error));

    })
});