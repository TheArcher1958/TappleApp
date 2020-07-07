import 'package:flutter/material.dart';
import 'package:tappleapp/View/LeaderboardsListScreen.dart';
import '../Globals.dart';
import 'LoginScreen.dart';
import 'PlayerStatsSearch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'XFNodeListScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
      Future.delayed(Duration(milliseconds: 500)).then((_) {
        if (globalUser != null) {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Color(0xff303c42),
              content: Text('Logged in as ' + globalUser.username,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          );
        }
      }
    )
    });
  }


  _launchStore(BuildContext context) async {
    const url = 'https://store.tapple.world';
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

  void _toggleScreen(num,ctx) {
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
      key: _scaffoldKey,
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
                _toggleScreen(1, context);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Leaderboards'),
              onTap: () {
                _toggleScreen(2, context);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Forums'),
              onTap: () {
                _toggleScreen(3,context);
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
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LoginScreen()));
                //Navigator.pushNamed(context, "/login");
              },
            ),
          ],
        ),
      ),

      body: listOfScreens[pageIndex],
    );
  }
}

