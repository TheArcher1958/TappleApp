import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<LoginResponse> fetchUserFromLogin(username, password) async {
  var response = await http.post('https://tapple.world/api/auth/',
      body: {
    'login': username, 'password': password
  },
    headers: {
      "XF-Api-Key": API_KEY,
    },
  );

  //print(response.body);
  final responseJson = json.decode(response.body);
  if(responseJson["success"] == true && responseJson["error"] == null) {
    return LoginResponse.fromJson(responseJson);
  } else {
    return null;
  }
}

class LoginResponse {
  final bool success;
  final User user;
  LoginResponse(this.user,this.success);
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      User.fromJson(json["user"]),
      json['success'] as bool,
    );
  }
}