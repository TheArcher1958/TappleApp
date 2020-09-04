import 'package:flutter/material.dart';
import 'package:tappleapp/Controller/XFAuthCheckNetworkController.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Globals.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _saveLoginDetails(storage, username, password) async {
    await storage.write(key: "tappleUsername", value: username);
    await storage.write(key: "tapplePassword", value: password);
  }

  _launchRegister(BuildContext context) async {
    const url = 'https://tapple.world/register';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Problem Loading Site'),
        ),
      );
    }
  }


  _handleLoginRequest(username, password, ctx) async {
    setState(() {
      _lockedLoginButton = true;
      _loading = true;
    });
    await fetchUserFromLogin(username, password).then((result){
      setState(() {
        _lockedLoginButton = false;
        _loading = false;
      });
      if(result == null) {
        final snackBar = SnackBar(
          backgroundColor: Color(0xff303c42),
          content: Text('Invalid Username or Password!',
          style: TextStyle(
            color: Colors.white,
          ),),
        );
        Scaffold.of(ctx).showSnackBar(snackBar);
      } else {
        _saveLoginDetails(storage, username, password);
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/loading', (Route<dynamic> route) => false);
      };
    });
  }
  bool _lockedLoginButton = false;
  bool _loading = false;
  bool _hidePasswordText = true;

  var _userController = TextEditingController();
  var _passController = TextEditingController();

  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _hidePasswordText = !_hidePasswordText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
          children: [
            _loading ? LinearProgressIndicator() : SizedBox(),
            ClipPath(
              clipper: CustomHalfCircleClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                color: Color(0xffFE7615),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,15,0),
                      child: Image.asset(
                        'assets/TappleLogo.jpg',
                        width: 90,
                        height: 90,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,10,0,0),
                      child: Text("Tapple",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontFamily: 'UniSansHeavy',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: _userController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                style: TextStyle(
                  fontFamily: "Roberto",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              child: TextField(
                cursorColor: Colors.white,
                controller: _passController,
                obscureText: _hidePasswordText,
                style: TextStyle(
                  fontFamily: "Roberto",
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => _toggleVisibility(),
                    icon: Icon(_hidePasswordText ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFE7615),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                  )
                ],
              ),
              child: SizedBox(
                height: 50,
                width: 250,
                child: RaisedButton(
                  child: const Text('Login', style: TextStyle(fontSize: 25)),
                  textColor: Colors.white,
                  onPressed: () {
                    if(_lockedLoginButton == false) {
                      if (_userController.text != "" && _passController.text !=
                          "") {
                        _handleLoginRequest(
                            _userController.text, _passController.text,
                            context);
                      }
                    }
                  },
                  color: Color(0xffFE7615),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Or",
              style: TextStyle(
              fontFamily: "UniSansHeavy",
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffFE7615),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6),
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                    spreadRadius: 3.0,
                  )
                ],
              ),
              child: SizedBox(
                height: 45,
                width: 200,
                child: RaisedButton(
                  child: const Text('Register', style: TextStyle(fontSize: 25)),
                  textColor: Colors.white,
                  onPressed: () {
                    _launchRegister(context);
                  },
                  color: Color(0xffFE7615),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
      ),
        ),
      )
    );
  }
}

class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height, size.width, size.height-30);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomHalfCircleClipper oldClipper) {
    return true;
  }
}