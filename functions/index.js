/* eslint-disable indent */
const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.intrusionAlert = functions.database
  .ref("ALARM_STATUS")
  .onUpdate((evt) => {
    const payload = {
      notification: {
        title: "INTRUSION ALERT",
        body: "There has been an intrusion.",
        badge: "1",
        sound: "default",
      },
      data: {
        title: "INTRUSION ALERT",
        body: "There has been an intrusion.",
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        screen: "AlertDetailPage",
      },
    };

    return admin
      .database()
      .ref("fcm-token")
      .once("value")
      .then((allToken) => {
        if (allToken.val() && evt.after.val() == "ON") {
          console.log("token available");
          const token = Object.keys(allToken.val());
          return admin.messaging().sendToDevice(token, payload);
        } else {
          console.log("No token available");
        }
      });
  });

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
