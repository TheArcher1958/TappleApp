import 'package:flutter/material.dart';
import 'package:tappleapp/Controller/XFCreateThreadNetworkController.dart';

class XFCreateThreadScreen extends StatefulWidget {
  final int nodeID;
  XFCreateThreadScreen(this.nodeID, {Key key}): super(key: key);
  @override
  _XFCreateThreadScreenState createState() => _XFCreateThreadScreenState();
}

class _XFCreateThreadScreenState extends State<XFCreateThreadScreen> {
  var _messageController = TextEditingController();
  var _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void postNewReply(message,title) async {
    await postThread(widget.nodeID, title, message).then((bool success){
      print(success.toString());
      if(success == true) {
        Navigator.pop(context, true);
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff303c42),
            content: Text('Unable to create thread.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        );
      }
    });

  }

  reactToStatusCode() async {
    await postNewReply(_messageController.text,_titleController.text);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create Thread"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) =>Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 2,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Title may not be blank';
                      } else {
                        return null;
                      }
                    },
                    controller: _titleController,
                    style: TextStyle(
                      fontFamily: "Roberto",
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "Thread title...",border: OutlineInputBorder(),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Message may not be blank';
                      } else {
                        return null;
                      }
                    },
                    controller: _messageController,
                    style: TextStyle(
                      fontFamily: "Roberto",
                    ),
                    maxLines: 12,
                    decoration: InputDecoration(hintText: "Write your message...",border: OutlineInputBorder(),),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: _submit,
                color: Color(0xffff0e19),
                child: Text("Post Reply"),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
  void _submit() {
    if(_formKey.currentState.validate()) {
      reactToStatusCode();
      _titleController.clear();
      _messageController.clear();
    }
  }
}
