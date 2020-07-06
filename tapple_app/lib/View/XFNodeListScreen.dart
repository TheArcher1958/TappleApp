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
        if(node.node_type_id == "Forum" && node.display_in_list == true) {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
          child: new ListView.builder
            (
              itemCount: data.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=>XFThreadListScreen(data[index])));
                  },
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Color(
                            0xFFFFDFDFDF)),
                        bottom: BorderSide(width: 0.5, color: Color(
                            0xFFFFDFDFDF)),
                      ),
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 220,
                          child: Text("${data[index].title}",
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),),
                        ),
                        SizedBox(width: 0,),
                        Container(
                          width: 178,
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  width: 0.5, color: Color(0xFFFF7F7F7F)),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[
                                Text("${data[index].type_data.last_thread_title}",
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                  ),),
                                Text("${data[index].type_data.last_post_username} ${String
                                    .fromCharCode($bull)} ${_toRecase(
                                    timeago.format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            data[index].type_data.last_post_date *
                                                1000)))}",
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                  ),),
                              ],
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}
