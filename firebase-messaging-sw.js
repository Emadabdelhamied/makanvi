importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

/*Update with yours config*/
const firebaseConfig = {
    apiKey: "AIzaSyDNmbUUM29l3-TYdwyyiGuoc-HrvsIegSk",
    authDomain: "makanvi-10592.firebaseapp.com",
    projectId: "makanvi-10592",
    storageBucket: "makanvi-10592.appspot.com",
    messagingSenderId: "324895378902",
    appId: "1:324895378902:web:3d092f70966f7790f56877",
    measurementId: "G-X24BLW96PK"
};
firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

/*messaging.onMessage((payload) => {
console.log('Message received. ', payload);*/
messaging.onBackgroundMessage(function (payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
        notificationOptions);
});