import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tapple'),
          backgroundColor: Color(0xffFE7615),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            new Container(
              color: Colors.yellow,
            ),
            new Container(
              color: Colors.orange,
            ),
            new Container(
              color: Colors.lightGreen,
            ),
            new Container(
              color: Colors.red,
            ),
          ],
        ),
        bottomNavigationBar: new TabBar(
          tabs: [
            Tab(
              icon: new Icon(Icons.home),
            ),
            Tab(
              icon: new Icon(Icons.rss_feed),
            ),
            Tab(
              icon: new Icon(Icons.perm_identity),
            ),
            Tab(icon: new Icon(Icons.settings),)
          ],
          labelColor: Color(0xffff0e19),
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Color(0xffFE7615),
        ),
      ),
    );
  }
}

