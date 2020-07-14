import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Globals.dart';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;




Future<CategoryList> fetchNodes() async {
  final response = await http.get(
    'https://tapple.world/api/nodes',
    headers: {"XF-Api-Key": API_KEY,
      "XF-Api-User": globalUser == null ? "" : "${globalUser.user_id}"},
  );
  final responseJson = json.decode(response.body);
  return CategoryList.fromJson(responseJson);
}

