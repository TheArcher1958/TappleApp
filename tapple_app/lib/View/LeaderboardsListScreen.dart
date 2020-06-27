import 'package:flutter/material.dart';
import 'LeaderboardsScreen.dart';

class LeaderboardsListScreen extends StatefulWidget {
  @override
  _LeaderboardsListScreenState createState() => _LeaderboardsListScreenState();
}

class _LeaderboardsListScreenState extends State<LeaderboardsListScreen> {

//  var leaderboardGamemodeNames = {
//    'totalxp': 'Total XP',
//    'normal_builduhc': 'Build UHC',
//    'normal_archer': 'Archer',
//    'normal_potion': 'Potion',
//    'normal_combo': 'Combo',
//    'normal_sg': 'SG',
//    'normal_skywars': 'Skywars',
//    'normal_soup': 'Soup',
//    'normal_parkour': 'Parkour',
//    'normal_sumo': 'Sumo',
//    'normal_spleef': 'Spleef',
//    'normal_horse': 'Horse',
//  };

  List<String> leaderboardNames = ["totalxp","normal_build","normal_archer","normal_potion","normal_combo","normal_sg","normal_skywars","normal_soup",
  "normal_parkour","normal_sumo","normal_spleef","normal_horse"];
  List<String> leaderboardDisplayNames = ["Total XP","Build UHC","Archer","Potion","Combo","SG","Skywars","Soup",
    "Parkour","Sumo","Spleef","Horse"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: leaderboardDisplayNames.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(leaderboardDisplayNames[index]),
          onTap: () {
            print(leaderboardNames[index]);
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LeaderboardsScreen(leaderboardNames[index])));
          },
        );
      },
    );
  }
}


