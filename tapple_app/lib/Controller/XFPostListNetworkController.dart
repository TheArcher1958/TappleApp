import 'dart:async';
import 'dart:convert';
import 'package:tappleapp/Model/XFPostListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Globals.dart';

Future<ThreadPosts> fetchPosts(int id,int page) async {
  final response = await http.get(
    'https://tapple.world/api/threads/${id}/posts?page=${page}',

    headers: {"XF-Api-Key": API_KEY,
      "XF-Api-User": globalUser == null ? "" : "${globalUser.user_id}",
    },
  );

  final responseJson = json.decode(response.body);
  return ThreadPosts.fromJson(responseJson);
}
