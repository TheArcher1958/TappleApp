import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tappleapp/View/RegisterScreen.dart';
import 'View/LoadingScreen.dart';
import 'View/LoginScreen.dart' as LoginScreen;


void main() async {
  SharedPreferences.setMockInitialValues({"eventNot": true});
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
        routes: {
          '/loading': (context) => LoadingScreen(),
          '/login': (context) => LoginScreen.LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xffFE7615),
          accentColor: Color(0xffff0e19),
          scaffoldBackgroundColor: Color(0xff2D3238),

          fontFamily: 'UniSansHeavy',
          primaryTextTheme: TextTheme(
              headline1: TextStyle(color: Colors.white)
          ),

          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Armata-Regular'),
          ),
        )
    ));

  });

}