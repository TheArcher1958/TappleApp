import 'package:flutter/material.dart';
import 'package:tappleapp/Controller/XFNodeListNetworkController.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';
import 'XFThreadListScreen.dart';
import 'package:charcode/charcode.dart';
import 'package:recase/recase.dart';
import 'package:timeago/timeago.dart' as timeago;


class XFNodeListScreen extends StatefulWidget {

  @override
  _XFNodeListScreenState createState() => _XFNodeListScreenState();
}

class _XFNodeListScreenState extends State<XFNodeListScreen> {
  List<Node> data;


  String _toRecase(theString) {
    ReCase rc = new ReCase(theString);
    return rc.titleCase;
  }

  String getAvatarURL(url, username) {
    if(url == null) {
      url = 'https://eu.ui-avatars.com/api/?name=${username}';
    }
    return url;
  }

  void getNodeList() async {
    fetchNodes().then((CategoryList result){

      List<Node> forumList = [];
      result.nodes.forEach((node) {
        if((node.node_type_id == "Forum" || node.node_type_id == "Category") && node.display_in_list == true && node.title != "Applications") {
          forumList.add(node);
        }
      });

      setState(() {
        data = forumList;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNodeList();
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) return Container(
        color: Color(0xff2D3238),
        padding: EdgeInsets.all(16.0),
        child:  Center(
          child: CircularProgressIndicator(),
        )
    );
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //image: NetworkImage("https://i.gyazo.com/8ba500f575cd16de7c7bf1ec0d6059e3.jpg"),
              image: AssetImage("assets/tappleBackground-min.jpg"),
              fit: BoxFit.cover
          ),
        ),
        child: new ListView.builder
          (
            itemCount: data.length,
            itemBuilder: (BuildContext ctxt, int index) {
              if(data[index].node_type_id == "Category") {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xff2c2f33),
                      border: Border(
                        top: BorderSide(width: 2, color: Color(
                            0xffff0e19)),
                        bottom: BorderSide(width: 0.5, color: Color(
                            0xFFFFDFDFDF)),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("${data[index].title}",style: TextStyle(fontFamily: "UniSansHeavy",fontSize: 20),),
                      ],
                    ),
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>XFThreadListScreen(data[index])));
                },
                child: Container(

                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xff3D4148),
                    border: Border(
                      top: BorderSide(width: 0.5, color: Color(
                          0xFFFFDFDFDF)),
                      bottom: BorderSide(width: 0.5, color: Color(
                          0xFFFFDFDFDF)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text("${data[index].title}",
                            overflow: TextOverflow.fade,
                            style: new TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        SizedBox(height: 0,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.50,
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    width: 0.5, color: Color(0xFFFF7F7F7F)),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[
                                  Text(data[index].type_data.last_thread_title == null ? "" :"${data[index].type_data.last_thread_title}",
                                    overflow: TextOverflow.fade,
                                    style: new TextStyle(
                                      fontSize: 13.0,
                                    ),),
                                  SizedBox(height: 5,),
                                  Text(data[index].type_data.last_post_date == null ? "" : "${data[index].type_data.last_post_username} ${String
                                      .fromCharCode($bull)} ${_toRecase(
                                      timeago.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              data[index].type_data.last_post_date *
                                                  1000)))}",
                                    overflow: TextOverflow.fade,
                                    style: new TextStyle(
                                      fontSize: 13.0,
                                    ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              );
            }
        )
    );
  }
}
