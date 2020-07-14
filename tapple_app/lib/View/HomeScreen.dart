import 'package:flutter/material.dart';
import 'package:tappleapp/Controller/TestNetworkRequest.dart';
import 'package:tappleapp/View/LeaderboardsListScreen.dart';
import 'package:tappleapp/View/SettingsPage.dart';
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

  Future<void> _showLogoutScreen() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tapple Account', style: TextStyle(fontSize: 25),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to sign out of your account?', style: TextStyle(fontFamily: "Roberto"),),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Sign Out'),
              onPressed: () async {
                globalUser = null;
                await storage.delete(key: "tappleUsername");
                await storage.delete(key: "tapplePassword");
                Navigator.pushReplacementNamed(context, "/loading");
              },
            ),
          ],
        );
      },
    );
  }


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
      child: Text('Welcome'),
    ),
    PlayerStatsSearch(),
    LeaderboardsListScreen(),
    XFNodeListScreen(),
    SettingsPage(),
  ];
  var pageIndex = 3;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Tapple',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Color(0xffFE7615),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              onTap: () {
                if(globalUser != null) {
                  Navigator.pop(context);
                  _showLogoutScreen();
                } else {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/login");
                }
              },
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/tappleBackground.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                accountName: Text(globalUser != null ? globalUser.username : "     Sign In", style: TextStyle(color: globalUser != null ? Colors.black : Colors.white),),
                accountEmail: Text(globalUser != null ? globalUser.user_title : ""),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: (globalUser != null ? (globalUser.avatar_urls["l"] != null ? NetworkImage(globalUser.avatar_urls["l"]) : NetworkImage("https://eu.ui-avatars.com/api/?name=${globalUser.username}")) : AssetImage("assets/emptyPersonIcon.jpg")),
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
                testNetworkRequest();
                Navigator.of(context).pop();
                _toggleScreen(4, context);
              },
            ),
          ],
        ),
      ),

      body: listOfScreens[pageIndex],
    );
  }
}

