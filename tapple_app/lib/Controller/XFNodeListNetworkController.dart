import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Model/XFNodeListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;




Future<CategoryList> fetchAlbum() async {
  final response = await http.get(
    'https://tapple.world/api/nodes',
    headers: {"XF-Api-Key": API_KEY},
  );
  final responseJson = json.decode(response.body);
  return CategoryList.fromJson(responseJson);
}

