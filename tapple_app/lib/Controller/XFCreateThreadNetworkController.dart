import 'package:tappleapp/Globals.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<bool> postThread(int node_id, String title, String message) async {
  var response = await http.post('https://tapple.world/api/threads/',
    body: {
      'node_id': node_id.toString(), 'title': title, 'message': message
    },
    headers: {
      "XF-Api-Key": API_KEY_POST,
      "XF-Api-User": globalUser == null ? "" : "${globalUser.user_id}",
    },
  );
  final responseJson = json.decode(response.body);
  return responseJson["success"] as bool;
}