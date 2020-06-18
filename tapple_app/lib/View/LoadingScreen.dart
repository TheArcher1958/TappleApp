import 'package:flutter/material.dart';
import 'HomeScreen.dart' as HomeScreen;
import 'LoginScreen.dart' as LoginScreen;
import 'playerStatsSearch.dart' as PlayerSearch;

import 'StatsViewScreen.dart' as StatViewer;


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _loading;



  @override
  void initState() {
    super.initState();
    _loading = false;
    Future.delayed(Duration(seconds:5), () {
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          //return LoginScreen.LoginScreen();
          //return StatViewer.StatsViewScreen();
          return PlayerSearch.PlayerStatsSearch();
        },
      ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2D3238),
      child: Column(

        children: [
          SizedBox(
            height: (MediaQuery
                .of(context)
                .size
                .height / 2) - 65,
          ),
          Image.asset(
            'assets/TappleLogo.jpg',
            width: 110,
            height: 110,
          ),
        ],
      ),
    );
  }
}

