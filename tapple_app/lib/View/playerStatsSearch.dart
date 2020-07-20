import 'package:flutter/material.dart';
import 'package:tappleapp/View/StatsViewScreen.dart';

class PlayerStatsSearch extends StatefulWidget {
  @override
  _PlayerStatsSearchState createState() => _PlayerStatsSearchState();
}

class _PlayerStatsSearchState extends State<PlayerStatsSearch> {
  var _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
              child: TextField(
                controller: _controller,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search for a Player',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: RaisedButton(
                child: const Text('Get Stats', style: TextStyle(fontSize: 23)),
                textColor: Colors.white,
                onPressed: () async {
                  final result = await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>StatsViewScreen(_controller.text)));
                  if(result == false) {
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Color(0xff303c42),
                          content: Text('Player Not Found.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                    );
                  }
                },
                color: Color(0xffFE7615),
              ),
            ),
          ],
        ),
      ),
    );
  }
}