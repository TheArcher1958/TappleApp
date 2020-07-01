import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _hidePasswordText = true;

  var _controller = TextEditingController();

  void _toggleVisibility() {
    setState(() {
      _hidePasswordText = !_hidePasswordText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: CustomHalfCircleClipper(),
            child: Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
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
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
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
              controller: _controller,
              obscureText: _hidePasswordText,
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

          FlatButton(
            onPressed: () {},
            textColor: Colors.grey,
            child: Text('Forgot Password',
              style: TextStyle(
                fontSize: 12,
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
                  color: Colors.black.withOpacity(0.8),
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
                onPressed: () {},
                color: Color(0xffFE7615),
              ),
            ),
          )
        ],
      ),
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
  }
}