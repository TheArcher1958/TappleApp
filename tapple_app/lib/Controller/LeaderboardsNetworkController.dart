import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';

Future<LeaderboardsObject> fetchResults(lbName) async {
  final response = await http.get('https://tapple.world/tools/${lbName}.json');

  if (response.statusCode == 200) {

    LeaderboardsObject statsObject = LeaderboardsObject.fromJson(jsonDecode(response.body));
    return statsObject;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    //throw Exception('Failed to load data');
    return LeaderboardsObject([LeaderboardsResponse("rank", "username", 0, "uuid", "xp")], false);
  }
}