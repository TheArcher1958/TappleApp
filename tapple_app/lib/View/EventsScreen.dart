import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:recase/recase.dart';


String _toRecase(theString) {
  ReCase rc = new ReCase(theString);
  return rc.titleCase;
}

class Item {
  String gameType;
  String teamSize;
  String gamemode;
  String experimentalIndex;
  String scenarios;
  String playerFill;
  String key;
  String date;
  String eventTitle;
  String message;
  String name;
  String time;

  Item(this.gameType,this.teamSize,this.gamemode,this.experimentalIndex,this.playerFill,this.scenarios,this.message,this.name,this.date,this.eventTitle,this.time);

  Item.fromJson(var value){
    this.gameType = value['gameType'];
    this.teamSize = value['teamSize'];
    this.gamemode = value['gamemode'];
    this.experimentalIndex = value['experimentalIndex'];
    this.playerFill = value['playerFill'];
    this.scenarios = value['scenarios'];
    this.message = value['message'];
    this.name = value['name'];
    this.date = value['date'];
    this.eventTitle = value['eventTitle'];
    this.time = value['time'];
  }
}

 String _getTime(date, time) {
  List<String> dates = date.split("-");
  List<String> times = time.split(":");
  DateTime theDate = DateTime(int.parse(dates[0]),int.parse(dates[1]),int.parse(dates[2]),int.parse(times[0]),int.parse(times[1]));

  return _toRecase(Jiffy(theDate).fromNow());
 }

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Item> items = List();
  final DBRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();

    DBRef.once().then((DataSnapshot dataSnapshot){
      setState(() {
        for(var value in dataSnapshot.value.values)
          value.forEach((key, values) {
            items.add(new Item.fromJson(values));
          });
      });
    });
  }

  Future<void> _refreshPage() async {
    setState(() {
      items.clear();
    });
    DBRef.once().then((DataSnapshot dataSnapshot){
      setState(() {
        for(var value in dataSnapshot.value.values)
          value.forEach((key, values) {
            items.add(new Item.fromJson(values));
          });
      });
    });
  }

  final f = new DateFormat('MMM. d, ''yyyy');
  @override
  Widget build(BuildContext context) {
    if(items.length == 0)
      return Container(
        color: Color(0xff2D3238),
        padding: EdgeInsets.all(16.0),
        child:  Center(
          child: CircularProgressIndicator(),
        )
    );
    if(items.length > 1) {
      items.sort((a,b) {
        print(a);
        print(b);
        List<String> dates = a.date.split("-");
        List<String> times = a.time.split(":");
        DateTime aDate = DateTime(int.parse(dates[0]),int.parse(dates[1]),int.parse(dates[2]),int.parse(times[0]),int.parse(times[1]),);
        List<String> bdates = b.date.split("-");
        List<String> btimes = b.time.split(":");
        DateTime bDate = DateTime(int.parse(bdates[0]),int.parse(bdates[1]),int.parse(bdates[2]),int.parse(btimes[0]),int.parse(btimes[1]));
        return bDate.millisecondsSinceEpoch.compareTo(aDate.millisecondsSinceEpoch);
      });
    }

    return Container(
      color: Color(0xff2D3238),
      child: RefreshIndicator(
        onRefresh: _refreshPage,
        child: new ListView.builder(itemBuilder: (BuildContext context, int index) {
          var scenList = items[index].scenarios.split(", ");
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff242424),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(items[index].eventTitle,style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 22),),
                        Text(f.format(DateTime.parse(items[index].date)),style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 20),),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${items[index].playerFill} Player Fill",style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 19.5,fontStyle: FontStyle.italic),),
                        Text(items[index].time + " UTC",style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 19.5),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Image.asset("assets/ExperimentalIndexing/Index${items[index].experimentalIndex}.png",width: MediaQuery.of(context).size.width * 0.5,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(7, 4, 7, 1),
                                    child: Text(items[index].gamemode,style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 17),),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffff0e19),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),

                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(7, 4, 7, 1),
                                    child: Text(
                                      items[index].gameType == "FFA" ? "${items[index].gameType}" : "${items[index].gameType}: ${items[index].teamSize}",
                                      style: TextStyle(
                                        fontFamily: "UniSansHeavy",fontSize: 17
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffFE7615),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),


                                for(var item in scenList) Container(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(7, 4, 7, 1),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontFamily: "UniSansHeavy",fontSize: 17
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff61656B),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),


                              ],
                              direction: Axis.horizontal,
                              spacing: 7,
                              runSpacing: 5,
                            ),
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          Text(_getTime(items[index].date, items[index].time),style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 19),),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ),
          );
        },
          itemCount: items==null?0:items.length,
        ),
      ),
    );
  }
}
