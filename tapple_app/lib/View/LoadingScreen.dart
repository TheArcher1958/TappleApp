import 'dart:async';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:tappleapp/Controller/XFAuthCheckNetworkController.dart';
import 'package:tappleapp/Globals.dart';
import 'HomeScreen.dart' as HomeScreen;
import 'package:firebase_remote_config/firebase_remote_config.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      checkForLogin(storage);
    });
  }

  Future<List<dynamic>> getLogin(storage) async {
    var tapUser = await storage.read(key: "tappleUsername");
    var tapPass = await storage.read(key: "tapplePassword");

    return [tapUser, tapPass];
  }

  _deleteLogin(storage) async {
    await storage.delete(key: "tappleUsername");
    await storage.delete(key: "tapplePassword");
  }

  void checkForLogin(storage) async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    if(remoteConfig.getString('appVersionNumber') == version) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text("A New Update is Available!"),
            subtitle: Text("Please update the app to continue using it."),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    } else {
      getLogin(storage).then((List<dynamic> result) async {
        if (result[0] != null && result[1] != null) {
          await fetchUserFromLogin(result[0], result[1]).then((userResponse) {
            if (userResponse == null) {
              _deleteLogin(storage);
            } else {
              globalUser = userResponse.user;
            }
          });
        } else {}
        Navigator.pushReplacement(context, MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return HomeScreen.HomeScreen();
          },
        ),);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2D3238),
      child: Column(

        children: [
          SizedBox(
            height: (MediaQuery
                .of(context)
                .size
                .height / 2) - 65,
          ),
          Image.asset(
            'assets/TappleLogo.jpg',
            width: 110,
            height: 110,
          ),
        ],
      ),
    );
  }
}

