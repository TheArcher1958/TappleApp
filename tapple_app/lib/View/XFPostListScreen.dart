import 'package:flutter/material.dart';
import 'package:recase/recase.dart';
import 'package:tappleapp/Controller/XFCreatePostNetworkController.dart';
import 'package:tappleapp/Globals.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tappleapp/Controller/XFPostListNetworkController.dart';
import 'package:tappleapp/Model/XFPostListObjectModel.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';

class XFPostListScreen extends StatefulWidget {
  final Thread parentThread;
  XFPostListScreen(this.parentThread, {Key key}): super(key: key);
  @override
  _XFPostListScreenState createState() => _XFPostListScreenState();
}

class _XFPostListScreenState extends State<XFPostListScreen> {
  ThreadPosts data;
  var _replyController = TextEditingController();
  final ScrollController _homeController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



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

  void getPostList(id, page) async {
    fetchPosts(id, page).then((ThreadPosts result){

      setState(() {
        data = result;
      });
    });
  }

  void postNewReply(message, oldData) async {
    await postReply(widget.parentThread.thread_id, message).then((int statusCode) async {
      await getPostList(widget.parentThread.thread_id, oldData.pagination.last_page);
      if(statusCode == 200) {

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff303c42),
            content: Text('Your reply has been posted!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff303c42),
            content: Text('Unable to post reply.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        );
      }
    });

  }

  reactToStatusCode(oldData) async {
    await postNewReply(_replyController.text + "\n\n\n[B][FONT=tahoma][SIZE=2][COLOR=rgb(251, 160, 38)]Posted from the Tapple mobile app.[/COLOR][/SIZE][/FONT][/B]", oldData);
  }

  @override
  void initState() {
    super.initState();
    getPostList(widget.parentThread.thread_id, 1);
  }

  @override
  Widget build(BuildContext context) {
    if(data == null) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.parentThread.title),
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.parentThread.title),
        centerTitle: true,
      ),
      body: Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
            child: new ListView.separated
              (
                controller: _homeController,
                separatorBuilder: (context, index) =>
                    Divider(
                      color: Color(0xff2D3238),
                      thickness: 0,
                      height: 15,
                    ),
                itemCount: data.posts.length + 1,
                itemBuilder: (BuildContext ctxt, int index) {
                  var paginationList = [
                    for(var i = 0; i < data.pagination.last_page; i += 1) i
                  ];
                  if (index == data.posts.length && globalUser != null) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            for(var item in paginationList ) Container(
                              width: 50,
                              child: FlatButton(
                                onPressed: data.pagination.current_page ==
                                    item + 1 ? () {} : () {
                                  setState(() {
                                    data = null;
                                  });
                                  getPostList(
                                      widget.parentThread.thread_id, item + 1);
                                  _homeController.animateTo(
                                    0.0,
                                    curve: Curves.easeOut,
                                    duration: const Duration(milliseconds: 300),
                                  );
                                },
                                child: Text((item + 1).toString(),
                                  style: TextStyle(
                                    color: data.pagination.current_page ==
                                        item + 1 ? Colors.red : Colors
                                        .white,),),
                                color: Color(0xff383c42),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          color: Color(0xff3D4148),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff383c42),
                                    border: Border(
                                      right: BorderSide(
                                          color: Color(0xFFFFDFDFDF),
                                          width: 0.5),
                                      left: BorderSide(
                                          color: Color(0xFFFFDFDFDF),
                                          width: 0.5),
                                      top: BorderSide(
                                          color: Color(0xFFFFDFDFDF),
                                          width: 0.5),
                                      bottom: BorderSide(
                                          color: Color(0xFFFFDFDFDF),
                                          width: 0.5),

                                    ),
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _replyController,
                                      style: TextStyle(
                                        fontFamily: "Roberto",
                                      ),
                                      maxLines: 8,
                                      decoration: InputDecoration.collapsed(
                                          hintText: "Write your reply..."),
                                    ),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    if (_replyController.text.trim() == "" ||
                                        _replyController.text.trim() != null) {
                                      var oldData = data;
                                      setState(() {
                                        data = null;
                                      });
                                      reactToStatusCode(oldData);
                                      _replyController.clear();
                                    }
                                  },
                                  color: Color(0xffff0e19),
                                  child: Text("Post Reply"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    );
                  } else if (index == data.posts.length && globalUser == null) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                for(var item in paginationList ) Container(
                                  width: 50,
                                  child: FlatButton(
                                    onPressed: () {
                                      getPostList(widget.parentThread.thread_id,
                                          item + 1);
                                      _homeController.animateTo(
                                        0.0,
                                        curve: Curves.easeOut,
                                        duration: const Duration(
                                            milliseconds: 300),
                                      );
                                    },
                                    child: Text((item + 1).toString()),
                                    color: data.pagination.current_page ==
                                        item + 1 ? Colors.red : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Text("You need to be signed in to post a reply."),
                            SizedBox(height: 10,),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Text("Sign In"),
                              color: Color(0xffff0e19),
                            )
                          ],
                        ),

                      ),
                    );
                  }
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
                        bottom: BorderSide(width: 0.5, color: Color(
                            0xFFFFDFDFDF)),
                        left: BorderSide(color: Color(0xFFFFDFDFDF),
                            width: 0.5),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 10),
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            getAvatarURL(data.posts[index].user
                                                .avatar_urls["l"],
                                                data.posts[index].user
                                                    .username)),
                                        radius: 45,
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        5, 0, 5, 0),
                                    child: Text(
                                      data.posts[index].username,
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 10),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 5, 5, 0),
                                      child: Container(
                                        child: Text("${_toRecase(timeago.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                data.posts[index].post_date *
                                                    1000)))}"),
                                      ),
                                    ),
                                    Divider(
                                      color: Color(0xFFFFDFDFDF),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 0, 5, 10),
                                      child: Container(
                                        child: Text(_filterMessage(
                                            data.posts[index].message)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Color(0xFFFFDFDFDF), width: 0.5),
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
          ),


    );
  }
}
