# flutter_Answer_me 

The application made for meddicon project.
We were asked to build Backend and Android application,the Backend will hold the data and communicate with the application.
User will enter his phone number and after verification, the User will get questions from the server and the answers will be sent to the server when the user ends.


## Note: before running the application

- Make sure to install Flutter
- Install the local server and run it on dev mode 

## Workflow
- The application using a local server to handle verification. 
- Make sure to enter area code for SMS example israel(+972XXXXXXXXX)
- After the user get verify it will get the user questions from server (JSON format).
- After the user end to fill the form the answers will be sent to server. 
- The application will closed automatic after 5 seconds

## Technology 

- Flutter (1.22)
- Bloc
- Async
- Http post/get


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
