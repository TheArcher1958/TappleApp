import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tappleapp/Globals.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<NodeResponse> fetchThreads(int id, int page) async {
  print(globalUser.user_id);
  final response = await http.get(
    'https://tapple.world/api/forums/${id}/threads?page=${page}',
    headers: {"XF-Api-Key": API_KEY,
    "XF-Api-User": "${globalUser == null ? "" : globalUser.user_id}"},

  );
  final responseJson = json.decode(response.body);
  return NodeResponse.fromJson(responseJson);
}

