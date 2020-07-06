import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Model/XFPostListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<ThreadPosts> fetchPosts(id) async {
  final response = await http.get(
    'https://tapple.world/api/threads/${id}/posts',
    headers: {"XF-Api-Key": API_KEY,
      "XF-Api-User": "12"},
  );

  final responseJson = json.decode(response.body);
  return ThreadPosts.fromJson(responseJson);
}
