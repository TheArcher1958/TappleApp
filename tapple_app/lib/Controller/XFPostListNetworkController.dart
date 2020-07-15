import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Model/XFPostListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Globals.dart';


Future<ThreadPosts> fetchPosts(int id, int page) async {
  var tapUser = await storage.read(key: "tappleUsername");
  var tapPass = await storage.read(key: "tapplePassword");
  var response;
  if(tapUser != null && tapPass != null) {
    response = await http.post(
      'https://tapple.world/archers_testing/mobile/readPosts.php',
      body: {
        'XF-Thread-ID': id.toString(), 'XF-Page': page.toString()
        , 'XF-Username': tapUser, 'XF-Password': tapPass,
      },
    );
  } else {
    response = await http.get(
      'https://tapple.world/api/threads/${id}/posts?page=${page}',
      headers: {
        "XF-Api-Key": API_KEY,
      },
    );
  }
  print(response.body);
  final responseJson = json.decode(response.body);
  return ThreadPosts.fromJson(responseJson);
}