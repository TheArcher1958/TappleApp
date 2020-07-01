import 'package:flutter/material.dart';
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';
import 'package:tappleapp/Controller/LeaderboardsNetworkController.dart';
import 'package:flip_card/flip_card.dart';
import 'package:tappleapp/Controller/xpToLevelsConverter.dart';
import 'package:intl/intl.dart';

import 'StatsViewScreen.dart';

class LeaderboardsScreen extends StatefulWidget {
  final String leaderboardPath;
  LeaderboardsScreen(this.leaderboardPath, {Key key}): super(key: key);

  @override
  _LeaderboardsScreenState createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  var rankColors = {
  'group.default': 'FFFFFF',
  'group.apple': 'FF5555',
  'group.appleplus': 'FFAA00',
  'group.godapple': 'FFFF55',
  'group.godapplelightgray': 'AAAAAA',
  'group.godapplepurple': 'AA00AA',
  'group.builder': '55FF55d',
  'group.creator': 'FF55FF',
  'group.trialmod': '00AAAA',
  'group.mod': '55FFFF',
  'group.trialdev': '5555FF',
  'group.dev': '5555FF',
  'group.owner': 'AA0000',
  };
  var rankNames = {
  'group.default': '',
  'group.apple': 'Apple',
  'group.appleplus': 'Apple+',
  'group.godapple': 'God Apple',
  'group.godapplelightgray': 'God Apple',
  'group.godapplepurple': 'God Apple',
  'group.builder': 'Builder',
  'group.creator': 'Creator',
  'group.trialmod': 'Helper',
  'group.mod': 'Moderator',
  'group.trialdev': 'Trial Dev',
  'group.dev': 'Dev',
  'group.owner': 'Owner',
  };

  var leaderboardGamemodeNames = {
    'totalxp': 'Total XP',
    'normal_build': 'Build UHC XP',
    'build_elo': 'Build UHC Elo',
    'normal_archer': 'Archer XP',
    'archer_elo': 'Archer Elo',
    'normal_potion': 'Potion XP',
    'potion_elo': 'Potion Elo',
    'normal_combo': 'Combo XP',
    'normal_sg': 'SG XP',
    'normal_skywars': 'Skywars XP',
    'normal_soup': 'Soup XP',
    'normal_parkour': 'Parkour XP',
    'parkour_elo': 'Parkour Elo',
    'normal_sumo': 'Sumo XP',
    'normal_spleef': 'Spleef XP',
    'normal_horse': 'Horse XP',
  };

  LeaderboardsObject data;
  void initState() {

    getObjectFromFuture(widget.leaderboardPath);
    super.initState();
  }


  Future<LeaderboardsObject> getData(lbName) async {
    return fetchResults(lbName);
  }

  void getObjectFromFuture(lbName) async {
    getData(lbName).then((LeaderboardsObject result){
      setState(() {
        data = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) return Container(
        color: Color(0xff2D3238),
        padding: EdgeInsets.all(16.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
            ),
          ],
        )
    );
    if(data.success == false) {
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(leaderboardGamemodeNames[widget.leaderboardPath]),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
              columns: [
                DataColumn(
                  label: Text("#", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'UniSansHeavy',
                  ),),
                  numeric: true,
                ),
                DataColumn(
                  label: Text("Username",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'UniSansHeavy',
                  ),),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("${widget.leaderboardPath.contains("elo") ? "Elo" : "XP"}",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'UniSansHeavy',
                  ),),
                  numeric: false,
                ),
              ],
              rows: data.leaderboard
                  .map(
                    (playerInfo) => DataRow(
                    cells: [
                      DataCell(
                        Text("${playerInfo.position}", style: TextStyle(fontSize: 16),),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>StatsViewScreen(playerInfo.username)));
                          // write your code..
                        },
                      ),
                      DataCell(
                        RichText(
                          text: TextSpan(
                            text: "${rankNames[playerInfo.rank]} ",
                            style: TextStyle(fontSize: 16, color: Color(int.parse("0xff${rankColors[playerInfo.rank]}"))),
                            children: <TextSpan>[
                              TextSpan(text: playerInfo.username, style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                            ],
                          ),
                        ),
                        //Text(playerInfo.username),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>StatsViewScreen(playerInfo.username)));

                          // write your code..
                        },
                      ),
                      DataCell(
                        Text(playerInfo.xp, style: TextStyle(fontSize: 16),),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>StatsViewScreen(playerInfo.username)));

                          // write your code..
                        },
                      ),
                    ]),
              )
                  .toList(),

            ),
          ),
        ),
    );
  }
}
