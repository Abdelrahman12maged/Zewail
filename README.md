Rozewell is an application developed using Flutter for communication between students and teachers at an educational center. It consists of groups for the subjects in which the student is enrolled. Students can post questions in each group, and these can be answered by other students and the teacher responsible for the group.

Libraries Used in the Application:
bloc: ^8.1.2

Explanation:
The BLoC (Business Logic Component) library is used for state management in Flutter applications. It separates business logic from the UI, making the code more organized and maintainable.
Purpose:
To manage the application's state and synchronize changes in the UI based on specific events.
shared_preferences: ^2.2.0

Explanation:
This library is used for storing and retrieving simple data locally on the device, such as user settings or preferences.
Purpose:
To store information like settings or options that need to be saved even after the app is closed.
dio: ^5.2.1+1

Explanation:
Dio is a powerful library for handling network requests in Flutter. It is used to perform HTTP operations such as GET and POST easily.
Purpose:
To perform network requests to communicate with servers and retrieve or send data.
image_picker: ^1.0.0

Explanation:
This library is used for selecting images from the device's gallery or camera.
Purpose:
To enable users to upload images in the app, such as posting images in posts.
webview_flutter: ^4.2.2

Explanation:
This library is used for displaying web content within a Flutter application.
Purpose:
To allow displaying web pages inside the app without needing to leave it.
flutter_sound: ^9.2.13

Explanation:
This library is used for recording and playing sound in Flutter applications.
Purpose:
To enable users to record and play audio within the app, such as voice messages.
audioplayers: ^4.1.0

Explanation:
This library is for playing audio files in Flutter applications.
Purpose:
To allow playing various audio files within the app, such as listening to recordings or voice messages.
firebase_messaging: ^14.6.6

Explanation:
This library is used for sending and receiving notifications in Flutter applications using Firebase Cloud Messaging.
Purpose:
To send real-time notifications to users when certain events occur within the app, such as new replies to posts.
Application Overview
The application consists of:

Subject Groups: Each student has a set of groups for the subjects they are enrolled in.
Posting Questions: Students can post questions in the form of posts within each subject group.
Interaction: Other students and the teacher responsible for the group can reply to the posts.
Using these libraries, effective communication between students and teachers can be achieved, providing a seamless user experience with advanced features such as real-time notifications and multimedia support.
