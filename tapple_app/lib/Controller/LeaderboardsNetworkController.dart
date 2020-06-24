import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Model/LeaderboardsObjectModel.dart';

Future<LeaderboardsObject> fetchResults() async {
  final response = await http.get('https://tapple.world/tools/normal_archer.json');

  if (response.statusCode == 200) {

    LeaderboardsObject statsObject = LeaderboardsObject.fromJson(jsonDecode(response.body));
    print(statsObject);
    return statsObject;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}