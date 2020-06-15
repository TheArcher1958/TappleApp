import 'package:flutter/material.dart';
import 'package:tappleapp/Model/playerStatsObjectModel.dart';
import 'package:tappleapp/Controller/PlayerStatsNetworkController.dart';
import 'package:flip_card/flip_card.dart';
import 'package:intl/intl.dart';




class StatsViewScreen extends StatefulWidget {
  @override
  _StatsViewScreenState createState() => _StatsViewScreenState();
}

class _StatsViewScreenState extends State<StatsViewScreen> {
  var playerName = "The_Archer";
  PlayerStatsObject data;
  void initState() {

    getObjectFromFuture();
    super.initState();
  }


  Future<PlayerStatsObject> getData() async {
    return fetchResults();
  }

  void getObjectFromFuture() async {
    getData().then((PlayerStatsObject result){
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

    return Scaffold(
      appBar: AppBar(
        title: Text(data.response.name + "'s Stats"),
        centerTitle: true
      ),
      body: new ListView(
          children: <Widget>[
            FlipCard(
            direction: FlipDirection.HORIZONTAL, // default
              front: Container(
                height: 135,
                child: Card(
                  elevation: 4,
                  child: Row(
                    children: <Widget>[

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                              child: Image.network("https://crafatar.com/avatars/${data.response.uuid}"),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Rank:", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                            Text("Discord:", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                            Text("First Login:", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                            Text("Level:", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                            Text("Time Played:", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("${data.response.rank}", style: TextStyle(fontSize: 17),),
                            Text("${data.response.discordName}#${ data.response.discriminator}", style: TextStyle(fontSize: 17),),
                            Text("${DateFormat.yMMMd().format(new DateTime.fromMillisecondsSinceEpoch(data.response.timestampFirstJoined))}", style: TextStyle(fontSize: 17),),
                            Text("${data.response.totalxp}", style: TextStyle(fontSize: 17),),
                            Text("${(data.response.timeplayedMiliseconds / 360000).toStringAsFixed(2)} Hours", style: TextStyle(fontSize: 17),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),




              back: Container(
                child: Container(
                  height: 135,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Casual Wins:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("Casual Losses:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("Casual WL/R:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("Comp Wins:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("Comp Losses:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("Comp WL/R:", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("${data.response.casualWins}", style: TextStyle(fontSize: 17),),
                              Text("${data.response.casualLosses}", style: TextStyle(fontSize: 17),),
                              Text("${(data.response.casualWins / data.response.casualLosses).toStringAsFixed(2)}", style: TextStyle(fontSize: 17),),
                              Text("${data.response.competitiveWins}", style: TextStyle(fontSize: 17),),
                              Text("${data.response.competitiveLosses}", style: TextStyle(fontSize: 17),),
                              Text("${(data.response.competitiveWins / data.response.competitiveLosses).toStringAsFixed(2)}", style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}






