import 'package:flutter/material.dart';
import 'package:tappleapp/View/StatsViewScreen.dart';
import 'View/LoadingScreen.dart';
import 'View/LoginScreen.dart' as LoginScreen;


void main() => runApp(MaterialApp(
  home: LoadingScreen(),
  routes: {
    //'/homeTab': (context) => FirstScreen(),
    //'/login': (context) => LoginScreen.LoginScreen(),
    '/login': (context) => LoadingScreen(),
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
