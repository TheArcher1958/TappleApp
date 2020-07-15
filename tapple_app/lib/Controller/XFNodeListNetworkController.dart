import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Globals.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<CategoryList> fetchNodes() async {
  var tapUser = await storage.read(key: "tappleUsername");
  var tapPass = await storage.read(key: "tapplePassword");
  var response;
  if(tapUser != null && tapPass != null) {
    response = await http.post(
      //'https://tapple.world/archers_testing/mobile/mobileReadFromForums.php',
      'https://tapple.world/archers_testing/mobile/readNodes.php',
      body: {
        'XF-Username': tapUser, 'XF-Password': tapPass,
      },
    );
  } else {
    response = await http.get(
      'https://tapple.world/api/nodes/',
      headers: {
        "XF-Api-Key": API_KEY,
      },
    );
  }
  final responseJson = json.decode(response.body);
  return CategoryList.fromJson(responseJson);
}

