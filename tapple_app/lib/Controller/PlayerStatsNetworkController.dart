import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Model/PlayerStatsObjectModel.dart';

Future<PlayerStatsObject> fetchResults(name) async {
  final response = await http.get('https://tapple.world/tools/playerV2.php?name=${name}');

  if (response.statusCode == 200) {

    PlayerStatsObject statsObject = PlayerStatsObject.fromJson(jsonDecode(response.body));

    return statsObject;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}