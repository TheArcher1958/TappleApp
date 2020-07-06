import 'package:flutter/material.dart';
import 'package:tappleapp/View/LeaderboardsListScreen.dart';
import 'package:tappleapp/View/styling.dart';
import 'LoginScreen.dart';
import 'PlayerStatsSearch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'LeaderboardsScreen.dart';
import 'package:tappleapp/Controller/XFNodeListNetworkController.dart';

import 'XFNodeListScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  _launchStore(BuildContext context) async {
    const url = 'https://store.tappleworld';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Problem Loading Store'),
        ),
      );
    }
  }

  void _toggleScreen(num) {
    setState(() {
      pageIndex = num;
    });
  }

  var listOfScreens = [
    Container(
      child: Text('Hey'),
    ),
    PlayerStatsSearch(),
    LeaderboardsListScreen(),
    XFNodeListScreen(),
    LoginScreen(),
  ];
  var pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                image: DecorationImage(image: AssetImage("assets/tappleBackground.png"),
                fit: BoxFit.cover,
                ),
                //color: Color(0xffff0e19),
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
              leading: Icon(Icons.show_chart),
              title: Text('Player Stats'),
              onTap: () {
                _toggleScreen(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Leaderboards'),
              onTap: () {
                _toggleScreen(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Forums'),
              onTap: () {
                _toggleScreen(3);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.local_grocery_store),
              title: Text('Store'),
              onTap: () {
                Navigator.of(context).pop();
                _launchStore(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                _toggleScreen(4);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),

      body: listOfScreens[pageIndex]
    );
  }
}

