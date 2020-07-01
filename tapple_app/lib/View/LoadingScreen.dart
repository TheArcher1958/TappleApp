import 'package:flutter/material.dart';
import 'HomeScreen.dart' as HomeScreen;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<List<dynamic>> getLogin(storage) async {
    var tapUser = storage.read(key: "tappleUsername");
    var tapPass = storage.read(key: "tapplePassword");

    return [tapUser, tapPass];
  }

  void checkForLogin(storage) async {
    getLogin(storage).then((List<dynamic> result){
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return HomeScreen.HomeScreen();
        },
      ),);
    });
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:3), () {
      final storage = new FlutterSecureStorage();
      checkForLogin(storage);
      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return HomeScreen.HomeScreen();
        },
      ),);
    });
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

