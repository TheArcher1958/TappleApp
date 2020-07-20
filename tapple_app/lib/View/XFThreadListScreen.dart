import 'package:flutter/material.dart';
import 'package:charcode/charcode.dart';
import 'package:recase/recase.dart';
import 'package:tappleapp/Globals.dart';
import 'package:tappleapp/View/XFCreateThreadScreen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tappleapp/Controller/XFThreadListNetworkController.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';
import 'XFPostListScreen.dart';


class XFThreadListScreen extends StatefulWidget {
  final Node parentNode;
  XFThreadListScreen(this.parentNode, {Key key}): super(key: key);
  @override
  _XFThreadListScreenState createState() => _XFThreadListScreenState();
}

class _XFThreadListScreenState extends State<XFThreadListScreen> {
  NodeResponse data;
  final ScrollController _homeController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  void getNodeList(id, page) async {
    fetchThreads(id, page).then((NodeResponse result){
      if(result.threads == null) {
        setState(() {
          data = NodeResponse([],[],Pagination(0, 0, 0));
        });
      } else {
        setState(() {
          data = result;
        });
      }
    });
  }

  _pushAndAwaitSuccess() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(builder:(context)=>XFCreateThreadScreen(widget.parentNode.node_id)));
    if(result == true) {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff303c42),
            content: Text('Thread created.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
      );
      setState(() {
        data = null;
      });
      getNodeList(widget.parentNode.node_id, 1);
    }
  }

  @override
  void initState() {
    super.initState();
    getNodeList(widget.parentNode.node_id, 1);
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
    var threadListWithStickys = [...data.sticky, ...data.threads];
    var paginationList = [for(var i=0; i<data.pagination.last_page; i+=1) i];
    if (threadListWithStickys.length > 0) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.parentNode.title),
          centerTitle: true,
        ),
        body: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: new ListView.builder
                (
                  controller: _homeController,
                  itemCount: threadListWithStickys.length + 2,
                  itemBuilder: (BuildContext ctxt, int index) {
                    if(index == 0) {
                      return Container(
                        child: RaisedButton(
                          onPressed: globalUser == null ? null : () {
                            _pushAndAwaitSuccess();
                          },
                          color: Color(0xffff0e19),
                          child: Text("Create Thread"),
                        ),
                      );
                    } else if(index == threadListWithStickys.length + 1) {
                      return Wrap(
                        direction: Axis.horizontal,
                        spacing: 0,
                        runSpacing: 0,
//                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          for(var item in paginationList ) Container(
                            width: 50,
                            child: FlatButton(
                              onPressed: data.pagination.current_page == item + 1 ? () {
                              } : () {
                                setState(() {
                                  data = null;
                                });
                                getNodeList(widget.parentNode.node_id, item + 1);
                                _homeController.animateTo(
                                  0.0,
                                  curve: Curves.easeOut,
                                  duration: const Duration(milliseconds: 300),
                                );
                              },
                              child: Text((item + 1).toString(),style: TextStyle(color: data.pagination.current_page == item + 1 ? Colors.red : Colors.white,),),
                              color: Color(0xff383c42),
                            ),
                          ),
                        ],
                      );
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>XFPostListScreen(threadListWithStickys[index - 1])));
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
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(backgroundImage: NetworkImage(
                                  getAvatarURL(
                                      threadListWithStickys[index - 1].user.avatar_urls["l"],
                                      threadListWithStickys[index - 1].user.username)),
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
                              width: MediaQuery.of(context).size.width * 0.51,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: <Widget>[
                                    Text(threadListWithStickys[index - 1].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    Text("${threadListWithStickys[index - 1].username} ${String
                                        .fromCharCode($bull)} ${_toRecase(
                                        timeago.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                threadListWithStickys[index - 1].post_date *
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
                                Text("Replies: ${threadListWithStickys[index - 1]
                                    .reply_count}"),
                                Text("Views: ${threadListWithStickys[index - 1].view_count}"),
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