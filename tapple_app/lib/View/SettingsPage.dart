import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: Divider(thickness: 1,),
        ),
        ListTile(
          title: Text('Notifications'),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,10,0),
          child: Divider(thickness: 1,),
        ),
        ListTile(
          title: Text('Other Settings'),
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
