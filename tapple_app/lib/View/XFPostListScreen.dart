import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tappleapp/Controller/XFPostListNetworkController.dart';
import 'package:tappleapp/Model/XFPostListObjectModel.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';

class XFPostListScreen extends StatefulWidget {
  final Thread parentThread;//if you have multiple values add here
  XFPostListScreen(this.parentThread, {Key key}): super(key: key);
  @override
  _XFPostListScreenState createState() => _XFPostListScreenState();
}

class _XFPostListScreenState extends State<XFPostListScreen> {
  ThreadPosts data;

  String _filterMessage(message) {
    final newMessage = message.replaceAllMapped(RegExp('(\\[\\/*\\w+[=a-zA-Z_\\-:/. ,0-9()\'"]*\\])'), (match) {
      return '';
    });
    return newMessage;
  }

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

  void getPostList(id) async {
    fetchPosts(id).then((ThreadPosts result){

      setState(() {
        data = result;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPostList(widget.parentThread.thread_id);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parentThread.title),
        centerTitle: true,
      ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8,5,8,0),
            child: new ListView.separated
              (
                separatorBuilder: (context, index) => Divider(
                  color: Color(0xff2D3238),
                  thickness: 0,
                  height: 15,
                ),
                itemCount: data.posts.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
                        bottom: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
                        left: BorderSide(color: Color(0xFFFFDFDFDF), width: 0.5),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Color(0xff484d56),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 100,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(5,10,5,10),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(getAvatarURL(data.posts[index].user.avatar_urls["l"], data.posts[index].user.username)),
                                        radius: 45,
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5,0,5,0),
                                    child: Text(
                                      data.posts[index].username,
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(5,10,5,10),
                                      child: Text(
                                        data.posts[index].user.user_title,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: ConstrainedBox(
                                constraints: new BoxConstraints(
                                    minHeight: 180
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,5,5,0),
                                      child: Container(
                                        child: Text("${_toRecase(timeago.format(DateTime.fromMillisecondsSinceEpoch(data.posts[index].post_date * 1000)))}"),
                                      ),
                                    ),
                                    Divider(
                                      color: Color(0xFFFFDFDFDF),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,0,5,10),
                                      child: Container(
                                        child: Text(_filterMessage(data.posts[index].message)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(color: Color(0xFFFFDFDFDF), width: 0.5),


                                ),
                                color: Color(0xff3D4148),
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
      ),
    );
  }
}
