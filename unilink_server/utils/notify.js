const admin = require('firebase-admin');

exports.sendNotification = (token, title, body) => {
  const message = {
    notification: { title, body },
    token: token,
  };
  admin.messaging().send(message);
};
