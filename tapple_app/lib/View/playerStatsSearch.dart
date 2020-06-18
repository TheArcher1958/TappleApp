import 'package:flutter/material.dart';
import 'package:tappleapp/View/HomeScreen.dart';
import 'package:tappleapp/View/StatsViewScreen.dart';

class PlayerStatsSearch extends StatefulWidget {
  @override
  _PlayerStatsSearchState createState() => _PlayerStatsSearchState();
}

class _PlayerStatsSearchState extends State<PlayerStatsSearch> {
  var _controller = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Player Stats"
        ),
        centerTitle: true,
      ),
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
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>StatsViewScreen(_controller.text)));

//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => StatsViewScreen(_controller.text),
//                    ),
//                  );
//                  Navigator.pushNamed(context, "/playerStats", arguments: {
//                    'playerName': _controller.text,
//                  });
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

