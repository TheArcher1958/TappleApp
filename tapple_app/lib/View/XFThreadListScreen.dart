import 'package:flutter/material.dart';
import 'package:charcode/charcode.dart';
import 'package:recase/recase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tappleapp/Controller/XFThreadListNetworkController.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';

import 'XFPostListScreen.dart';


class XFThreadListScreen extends StatefulWidget {
  final Node parentNode;//if you have multiple values add here
  XFThreadListScreen(this.parentNode, {Key key}): super(key: key);
  @override
  _XFThreadListScreenState createState() => _XFThreadListScreenState();
}

class _XFThreadListScreenState extends State<XFThreadListScreen> {
  NodeResponse data;

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

  void getNodeList(id) async {
    fetchThreads(id).then((NodeResponse result){

      setState(() {
        data = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNodeList(widget.parentNode.node_id);
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
    if (data.threads.length > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.parentNode.title),
          centerTitle: true,
        ),
        body: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
              child: new ListView.builder
                (
                  itemCount: data.threads.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>XFPostListScreen(data.threads[index])));
                      },
                      child: Container(
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(backgroundImage: NetworkImage(
                                  getAvatarURL(
                                      data.threads[index].user.avatar_urls["l"],
                                      data.threads[index].user.username)),
                                radius: 30,),
                            ),
                            SizedBox(width: 0,),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 0.5, color: Color(0xFFFF7F7F7F)),
                                  right: BorderSide(
                                      width: 0.5, color: Color(0xFFFF7F7F7F)),
                                ),
                              ),
                              width: 220,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[
                                    Text(data.threads[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    Text("${data.threads[index].username} ${String
                                        .fromCharCode($bull)} ${_toRecase(
                                        timeago.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                data.threads[index].post_date *
                                                    1000)))}",
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 5,),

                            Column(
                              children: <Widget>[
                                Text("Replies: ${data.threads[index]
                                    .reply_count}"),
                                Text("Views: ${data.threads[index].view_count}"),
                              ],
                            ),
                          ],

                        ),
                      ),
                    );
                  }
              ),
            )
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.parentNode.title),
          centerTitle: true,
        ),
        body: Container(
          child: Center(child: Text("Nothing to see here!"),),
        ),
      );
    }
  }
}
