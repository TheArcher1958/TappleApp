import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tappleapp/View/RegisterScreen.dart';
import 'View/LoadingScreen.dart';
import 'View/LoginScreen.dart' as LoginScreen;
import 'dart:io' show Platform;



void main() async {
  SharedPreferences.setMockInitialValues({"eventNot": true});
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    options: Platform.isIOS
        ? const FirebaseOptions(
      googleAppID: '1:930597125548:ios:246da77e5219e29ec80e09',
      gcmSenderID: '930597125548',
      databaseURL: 'https://eventspage-6bfe2.firebaseio.com',
      apiKey:'AIzaSyBkyGvEd4Fe5CLM8O7Awpra8h3YCrGfevw',
    )
        : const FirebaseOptions(
      googleAppID: '1:930597125548:android:ce9d280aafd3d07ac80e09',
      apiKey: 'AIzaSyBTsyrQm9sp6xUYQGlJMw2l1pM36viU5S0',
      databaseURL: 'https://eventspage-6bfe2.firebaseio.com',
    ), name: "TappleApp",
  );
  runApp(MaterialApp(
    home: LoadingScreen(),
    routes: {
      //'/homeTab': (context) => FirstScreen(),
      '/loading': (context) => LoadingScreen(),
      '/login': (context) => LoginScreen.LoginScreen(),
      '/register': (context) => RegisterScreen(),
    },
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,

        primaryColor: Color(0xffFE7615),
        accentColor: Color(0xffff0e19),
        scaffoldBackgroundColor: Color(0xff2D3238),


        // Define the default font family.
        fontFamily: 'UniSansHeavy',
        primaryTextTheme: TextTheme(
          headline1: TextStyle(color: Colors.white)
        ),

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Armata-Regular'),
        ),
      )
  ));
}



