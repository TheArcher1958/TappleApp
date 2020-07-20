import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tappleapp/Model/PlayerStatsObjectModel.dart';

Future<PlayerStatsObject> fetchResults(name) async {
  final response = await http.get('https://tapple.world/tools/playerV2.php?name=${name}');
  if (response.statusCode == 200) {

    final responseJson = json.decode(response.body);
    if(responseJson["success"] == true && responseJson["error"] == null) {
      return PlayerStatsObject.fromJson(responseJson);
    } else {
      return null;
    }
    print(response.body);
    PlayerStatsObject statsObject = PlayerStatsObject.fromJson(jsonDecode(response.body));
    return statsObject;
  } else {
    throw Exception('Failed to load data');
  }
}