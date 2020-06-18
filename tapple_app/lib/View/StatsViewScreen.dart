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
  var playerName = "erferno";
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

  PlayerStatsObject data;
  void initState() {

    getObjectFromFuture();
    super.initState();
  }


  Future<PlayerStatsObject> getData() async {
    return fetchResults(playerName);
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
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 155,
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
                              Text("${rankNames[data.response.rank]}", style: TextStyle(fontSize: 17, color: Color(int.parse("0xff${rankColors[data.response.rank]}"))),),
                              Text("${data.response.discordName}#${data.response.discriminator}", style: TextStyle(fontSize: 17),),
                              Text("${DateFormat.yMMMd().format(new DateTime.fromMillisecondsSinceEpoch(data.response.timestampFirstJoined))}", style: TextStyle(fontSize: 17),),
                              Text("${data.response.totalxp}", style: TextStyle(fontSize: 17),), // TODO: Add formula to convert xp to levels
                              Text("${(data.response.timeplayedMiliseconds / 360000).toStringAsFixed(2)} hr", style: TextStyle(fontSize: 17),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),




                back: Container(
                  child: Container(
                    height: 155,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                                Text("Competitive", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${(data.response.casualWins / data.response.casualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.casualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.casualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),






                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.competitiveWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.competitiveLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.competitiveWins / data.response.competitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.competitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.competitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),







      /*
      SECOND FLIP CARD | SECOND FLIP CARD | SECOND FLIP CARD | SECOND FLIP CARD | SECOND FLIP CARD | SECOND FLIP CARD | SECOND FLIP CARD
      */




            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 155,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Build Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                            Text("Build Comp", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.builduhcCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.builduhcCasualWins / data.response.builduhcCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),






                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.builduhcCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.builduhcCompetitiveWins / data.response.builduhcCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                // SECOND CARD BACK | SECOND CARD BACK | SECOND CARD BACK | SECOND CARD BACK | SECOND CARD BACK |


                back: Container(
                  child: Container(
                    height: 155,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Archer Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                                Text("Archer Comp", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.archerCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.archerCasualWins / data.response.archerCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),






                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.archerCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.archerCompetitiveWins / data.response.archerCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),











            // THIRD CARD | THIRD CARD | THIRD CARD | THIRD CARD | THIRD CARD | THIRD CARD |










            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 155,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Potion Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                            Text("Potion Comp", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.potionCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.potionCasualWins / data.response.potionCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),






                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.potionCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.potionCompetitiveWins / data.response.potionCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                // THIRD CARD BACK | THIRD CARD BACK | THIRD CARD BACK | THIRD CARD BACK | THIRD CARD BACK |


                back: Container(
                  child: Container(
                    height: 155,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Combo Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                                Text("SG Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.comboCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.comboCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.comboCasualWins / data.response.comboCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.comboCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.comboCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),






                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.sgCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.sgCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.sgCasualWins / data.response.sgCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.sgCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.sgCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),









// FOURTH CARD | FOURTH CARD | FOURTH CARD | FOURTH CARD | FOURTH CARD | FOURTH CARD |










            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 155,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Skywars Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                            Text("Soup Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.skywarsCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.skywarsCasualWins / data.response.skywarsCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),






                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.soupCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.soupCasualWins / data.response.soupCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                // FOURTH CARD BACK | FOURTH CARD BACK | FOURTH CARD BACK | FOURTH CARD BACK | FOURTH CARD BACK |


                back: Container(
                  child: Container(
                    height: 155,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Parkour Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                                Text("Parkour Comp", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.parkourCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.parkourCasualWins / data.response.parkourCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),






                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[

                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.parkourCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.parkourCompetitiveWins / data.response.parkourCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),










            // FIFTH CARD | FIFTH CARD | FIFTH CARD | FIFTH CARD | FIFTH CARD | FIFTH CARD |










            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  height: 155,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Sumo Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                            Text("Spleef Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.sumoCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.sumoCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.sumoCasualWins / data.response.sumoCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.sumoCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.sumoCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),






                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[

                                      Text("Wins:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Losses:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("W/L:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Winstreak:", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("Best Winstreak:", style: TextStyle(
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
                                      Text("${data.response.spleefCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${(data.response.spleefCasualWins / data.response.spleefCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),



                // FIFTH CARD BACK | FIFTH CARD BACK | FIFTH CARD BACK | FIFTH CARD BACK | FIFTH CARD BACK |


                back: Container(
                  child: Container(
                    height: 155,
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Horse Casual", style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: 'UniSansHeavy',
                                ),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Wins:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Losses:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("W/L:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Winstreak:", style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),),
                                          Text("Best Winstreak:", style: TextStyle(
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
                                          Text("${data.response.horseCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.horseCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${(data.response.horseCasualWins / data.response.horseCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.horseCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.horseCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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






