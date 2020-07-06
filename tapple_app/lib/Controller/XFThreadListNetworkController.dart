import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tappleapp/Model/XFThreadListObjectModel.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<NodeResponse> fetchThreads(id) async {
  final response = await http.get(
    'https://tapple.world/api/forums/${id}/threads',
    headers: {"XF-Api-Key": API_KEY,
    "XF-Api-User": "12"},

  );
  final responseJson = json.decode(response.body);
  return NodeResponse.fromJson(responseJson);
}

