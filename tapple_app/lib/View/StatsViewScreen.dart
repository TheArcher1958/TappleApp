import 'package:flutter/material.dart';
import 'package:tappleapp/Model/PlayerStatsObjectModel.dart';
import 'package:tappleapp/Controller/PlayerStatsNetworkController.dart';
import 'package:flip_card/flip_card.dart';
import 'package:tappleapp/Controller/xpToLevelsConverter.dart';
import 'package:intl/intl.dart';




class StatsViewScreen extends StatefulWidget {
  final String playerName;
  StatsViewScreen(this.playerName, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _StatsViewScreenState();
}

class _StatsViewScreenState extends State<StatsViewScreen> {

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
    return fetchResults(widget.playerName);
  }

  void getObjectFromFuture() async {
    getData().then((PlayerStatsObject result){
      if(result == null) {
        Navigator.pop(context, false);
      } else {
        setState(() {
          data = result;
        });
      }
    });
  }

  double getWinLoss(wins, losses) {
    if(losses == 0 && wins == 0) {
      return 0;
    } else if(wins / losses == double.infinity) {
      return 1;
    } else {
      return wins / losses;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tapple"),
          centerTitle: true,
        ),
        body: Container(
            color: Color(0xff2D3238),
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(),
            )
        ),
      );
    }

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
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.height * 0.125,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
                                child: Image.network("https://crafatar.com/avatars/${data.response.uuid}"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,0,0),
                          child: Container(
                            width: MediaQuery.of(context).size.height * 0.145,
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
                                Text("Total XP:", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("${rankNames[data.response.rank]}", style: TextStyle(fontSize: 16, color: Color(int.parse("0xff${rankColors[data.response.rank]}"))),),
                                Text("${data.response.discordName}#${data.response.discriminator}", style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,),
                                Text("${DateFormat.yMMMd().format(new DateTime.fromMillisecondsSinceEpoch(data.response.timestampFirstJoined))}", style: TextStyle(fontSize: 16),),
                                Text("${getLevelInfo(data.response.totalxp).levelAndFraction.toStringAsFixed(2)}", style: TextStyle(fontSize: 16),), // TODO: Add formula to convert xp to levels
                                Text("${(data.response.timeplayedMiliseconds / 360000).toStringAsFixed(2)} hr", style: TextStyle(fontSize: 16),),
                                Text("${data.response.totalxp.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),




                back: Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
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
                                          Text("${getWinLoss(data.response.casualWins, data.response.casualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                          Text("${getWinLoss(data.response.competitiveWins, data.response.competitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                  height: MediaQuery.of(context).size.height * 0.27,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Build XP:  ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("${data.response.builduhcXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Build Elo:  ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("${data.response.builduhcElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                      Text("${getWinLoss(data.response.builduhcCasualWins, data.response.builduhcCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.builduhcCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.builduhcCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.builduhcCompetitiveWins, data.response.builduhcCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                    height: MediaQuery.of(context).size.height * 0.27,
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Archer XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.archerXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Archer Elo:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.archerElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                          Text("${getWinLoss(data.response.archerCasualWins, data.response.archerCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${data.response.archerCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.archerCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${getWinLoss(data.response.archerCompetitiveWins, data.response.archerCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                  height: MediaQuery.of(context).size.height * 0.27,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Potion XP:  ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("${data.response.potionXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Potion Elo:  ", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                              Text("${data.response.potionElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                      Text("${getWinLoss(data.response.potionCasualWins, data.response.potionCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.potionCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.potionCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.potionCompetitiveWins, data.response.potionCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                    height: MediaQuery.of(context).size.height * 0.27,
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Combo XP:  ", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("${data.response.comboXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("SG XP:  ", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),),
                                      Text("${data.response.sgXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                          Text("${getWinLoss(data.response.comboCasualWins, data.response.comboCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${data.response.sgCasualWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.sgCasualLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${getWinLoss(data.response.sgCasualWins, data.response.sgCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                  height: MediaQuery.of(context).size.height * 0.27,
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
                            Text("Skywars Comp", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Skywars XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.skywarsXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Skywars Elo:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.skywarsElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                      Text("${getWinLoss(data.response.skywarsCasualWins, data.response.skywarsCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.skywarsCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.skywarsCompetitiveWins, data.response.skywarsCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.skywarsCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
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
                    height: MediaQuery.of(context).size.height * 0.27,
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Parkour XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.parkourXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Parkour Elo:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.parkourElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                          Text("${getWinLoss(data.response.parkourCasualWins, data.response.parkourCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("${data.response.parkourCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                          Text("${data.response.parkourCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                          Text("${getWinLoss(data.response.parkourCompetitiveWins, data.response.parkourCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Spleef Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                            Text("Spleef Comp", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Spleef XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.spleefXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Spleef Elo:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.spleefElo.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.spleefCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.spleefCasualWins, data.response.spleefCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.spleefCompetitiveWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCompetitiveLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.spleefCompetitiveWins, data.response.spleefCompetitiveLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCompetitiveWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.spleefCompetitiveBestWinstreak}", style: TextStyle(fontSize: 17),),
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
                  height: MediaQuery.of(context).size.height * 0.27,
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
                            Text("Soup Casual", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              fontFamily: 'UniSansHeavy',
                            ),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Sumo XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.sumoXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Soup XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.soupXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
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
                                      Text("${getWinLoss(data.response.sumoCasualWins, data.response.sumoCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("${data.response.soupCasualWins}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualLosses}", style: TextStyle(fontSize: 17),),
                                      Text("${getWinLoss(data.response.soupCasualWins, data.response.soupCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualWinstreak}", style: TextStyle(fontSize: 17),),
                                      Text("${data.response.soupCasualBestWinstreak}", style: TextStyle(fontSize: 17),),
                                    ],
                                  ),
                                ),
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






// SIXTH CARD | SIXTH CARD | SIXTH CARD | SIXTH CARD | SIXTH CARD | SIXTH CARD |










            Padding(
              padding: const EdgeInsets.all(3.0),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  child: Container(
                    height: 195,
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Horse XP:  ", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),),
                                  Text("${data.response.horseXP.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}", style: TextStyle(
                                    fontSize: 16,
                                  ),),
                                ],
                              ),
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
                                          Text("${getWinLoss(data.response.horseCasualWins, data.response.horseCasualLosses).toStringAsFixed(1)}", style: TextStyle(fontSize: 17),),
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



                // SIXTH CARD BACK | SIXTH CARD BACK | SIXTH CARD BACK | SIXTH CARD BACK | SIXTH CARD BACK |


                back: Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Center(
                    child: Container(
                      child: Container(
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset("assets/derpTapL.png"),
                          ),
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