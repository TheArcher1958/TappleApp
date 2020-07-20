import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> eventNot;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    eventNot = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('eventNot') ?? true);
    });
  }

  _toggleEventNots(bool newVal) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      eventNot = prefs.setBool("eventNot", newVal).then((bool success) {
        return newVal;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(eventNot == null) return Container(
        color: Color(0xff2D3238),
        padding: EdgeInsets.all(16.0),
        child:  Center(
          child: CircularProgressIndicator(),
        )
    );

    return Container(
      color: Color(0xff2D3238),
      child: FutureBuilder(
          future: eventNot,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,10,0),
                        child: Divider(thickness: 1,),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Event Notifications'),
                            Switch(
                              value: snapshot.data,
                              onChanged: (val) {
                                _toggleEventNots(val);
                                val == true ? _fcm.subscribeToTopic('events') : _fcm.unsubscribeFromTopic('events');
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,10,0),
                        child: Divider(thickness: 1,),
                      ),

                      ListTile(
                        title: Text('App Info'),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationIcon: Image.asset("assets/tappleAppIcon.png",width: 60,height: 60,),
                            applicationVersion: '1.0',
                            applicationName: 'Tapple',
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10,0,10,0),
                        child: Divider(thickness: 1,),
                      ),
                    ],
                  );
                }
            }
          }
      ),
    );
  }
}
