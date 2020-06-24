import 'package:flutter/material.dart';
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';
import 'package:tappleapp/Controller/LeaderboardsNetworkController.dart';
import 'package:flip_card/flip_card.dart';
import 'package:tappleapp/Controller/xpToLevelsConverter.dart';
import 'package:intl/intl.dart';

class LeaderboardsScreen extends StatefulWidget {
  @override
  _LeaderboardsScreenState createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  LeaderboardsObject data;
  void initState() {

    getObjectFromFuture();
    super.initState();
  }


  Future<LeaderboardsObject> getData() async {
    return fetchResults();
  }

  void getObjectFromFuture() async {
    getData().then((LeaderboardsObject result){
      setState(() {
        data = result;
        print(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
