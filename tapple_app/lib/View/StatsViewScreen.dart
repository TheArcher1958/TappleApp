import 'package:flutter/material.dart';
import 'package:tappleapp/Model/playerStatsObjectModel.dart';
import 'package:tappleapp/Controller/PlayerStatsNetworkController.dart';


class StatsViewScreen extends StatefulWidget {
  @override
  _StatsViewScreenState createState() => _StatsViewScreenState();
}

class _StatsViewScreenState extends State<StatsViewScreen> {
  void initState() {
    var model = getData();
    super.initState();
  }

  Future<PlayerStatsObject> getData() async {
    PlayerStatsObject playerStats = await fetchResults();
    print(playerStats.response.sumoCasualWinstreak);
    return fetchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}






