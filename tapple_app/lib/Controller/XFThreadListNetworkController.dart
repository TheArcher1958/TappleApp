import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Globals.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;

Future<NodeResponse> fetchThreads(int id, int page) async {
  var tapUser = await storage.read(key: "tappleUsername");
  var tapPass = await storage.read(key: "tapplePassword");
  var response;
  if(tapUser != null && tapPass != null) {
    response = await http.post(
      'https://tapple.world/archers_testing/mobile/readThreads.php',
      body: {
        'XF-Node-ID': id.toString(), 'XF-Page': page.toString()
        , 'XF-Username': tapUser, 'XF-Password': tapPass,
      },
    );
  } else {
    response = await http.get(
      'https://tapple.world/api/forums/${id}/threads?page=${page}',
      headers: {
        "XF-Api-Key": API_KEY,
      },
    );
  }
  print(response.body);
  final responseJson = json.decode(response.body);
  return NodeResponse.fromJson(responseJson);
}

