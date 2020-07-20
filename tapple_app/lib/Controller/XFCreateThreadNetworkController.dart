import 'dart:math';

import 'package:tappleapp/Globals.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> getLogin(storage) async {
  var tapUser = await storage.read(key: "tappleUsername");
  var tapPass = await storage.read(key: "tapplePassword");
  return [tapUser, tapPass];
}

Future<bool> postThread(int node_id, String title, String message) async {
  var loginInfo = await getLogin(storage);
  var response = await http.post('https://tapple.world/archers_testing/mobile/mobilePostToForums.php',
    body: {
      'XF-Node-ID': node_id.toString(), 'XF-Thread-Title': title, 'XF-Thread-Message': message
      , 'XF-Username': loginInfo[0], 'XF-Password': loginInfo[1], 'XF-Task': "createNewThread"
    },
  );
  final responseJson = json.decode(response.body);
  return responseJson["success"] as bool;
}