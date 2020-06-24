import 'package:flutter/material.dart';
import 'PlayerStatsSearch.dart';
import 'LeaderboardsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _toggleScreen(num) {
    setState(() {
      thing = num;
    });
  }

  var listOfScreens = [
    Container(
      child: Text('Hey'),
    ),
    PlayerStatsSearch(),
    LeaderboardsScreen(),
  ];
  var thing = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tapple',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          backgroundColor: Color(0xffFE7615),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Tapple',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Player Stats'),
                onTap: () {
                  _toggleScreen(1);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Leaderboards'),
                onTap: () {
                  _toggleScreen(2);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),

        body: listOfScreens[thing]

//        TabBarView(

//          physics: NeverScrollableScrollPhysics(),
//          children: [
//            new Container(
//              color: Color(0xFF1d1d1d),
//              child: Text('Player Stats'),
//            ),
//            new Container(
//              color: Colors.orange,
//            ),
//            new Container(
//              color: Colors.lightGreen,
//            ),
//            new Container(
//              color: Colors.red,
//            ),
//          ],
//        ),
//        bottomNavigationBar: new TabBar(
//          tabs: [
//            Tab(
//              icon: new Icon(Icons.home),
//            ),
//            Tab(
//              icon: new Icon(Icons.rss_feed),
//            ),
//            Tab(
//              icon: new Icon(Icons.perm_identity),
//            ),
//            Tab(icon: new Icon(Icons.settings),)
//          ],
//          labelColor: Color(0xffff0e19),
//          unselectedLabelColor: Colors.white,
//          indicatorSize: TabBarIndicatorSize.label,
//          indicatorPadding: EdgeInsets.all(5.0),
//          indicatorColor: Color(0xffFE7615),
//        ),
      ),
    );
  }
}

