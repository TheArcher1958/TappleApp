import 'package:flutter/material.dart';
import 'package:tappleapp/Controller/XFNodeListNetworkController.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';


class XFNodeListScreen extends StatefulWidget {

  @override
  _XFNodeListScreenState createState() => _XFNodeListScreenState();
}

class _XFNodeListScreenState extends State<XFNodeListScreen> {
  List<Node> data;

  void getNodeList() async {
    fetchAlbum().then((CategoryList result){
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
      child: new ListView.builder
        (
          itemCount: data.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return InkWell(
              onTap: () {

              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xFFFFDFDFDF)),
                    bottom: BorderSide(width: 0.5, color: Color(0xFFFF7F7F7F)),
                  ),
                ),
                child: SizedBox(
                  height: 50,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15,0,0,0),
                        child: Text(
                          data[index].title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                      //data[index].title
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}
