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

  List<String> kitImagePaths = ["assets/TappleMapsShaders/tappleTotalxp-min.png","assets/TappleMapsShaders/tappleBuild-min.png", "assets/TappleMapsShaders/tappleBuildElo-min.png",
    "assets/TappleMapsShaders/tappleArcher-min.png","assets/TappleMapsShaders/tappleArcherElo-min.png", "assets/TappleMapsShaders/tapplePotion-min.png",
    "assets/TappleMapsShaders/tapplePotionElo-min.png", "assets/TappleMapsShaders/tappleCombo-min.png","assets/TappleMapsShaders/tappleSG-min.png",
    "assets/TappleMapsShaders/tappleSkywars-min.png","assets/TappleMapsShaders/tappleSoup-min.png","assets/TappleMapsShaders/tappleParkour-min.png",
    "assets/TappleMapsShaders/tappleParkourElo-min.png","assets/TappleMapsShaders/tappleSumo-min.jpg", "assets/TappleMapsShaders/tappleSpleef-min.png",
    "assets/TappleMapsShaders/tappleHorse-min.png"];
  List<String> leaderboardNames = ["totalxp","normal_build", "build_elo","normal_archer","archer_elo", "normal_potion","potion_elo", "normal_combo","normal_sg","normal_skywars","normal_soup",
  "normal_parkour","parkour_elo", "normal_sumo","normal_spleef","normal_horse"];
  List<String> leaderboardDisplayNames = ["Total XP","Build UHC XP","Build UHC Elo", "Archer XP","Archer Elo", "Potion XP","Potion Elo", "Combo XP","SG XP","Skywars XP","Soup XP",
    "Parkour XP","Parkour Elo", "Sumo XP","Spleef XP","Horse XP"];

  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(leaderboardNames.length, (index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(kitImagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(leaderboardDisplayNames[index], style: TextStyle(fontSize: 18),),

                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder:(context)=>LeaderboardsScreen(leaderboardNames[index])));
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      );
  }
}


