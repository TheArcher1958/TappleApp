import 'package:tappleapp/Globals.dart';
import '../SensitiveCredentials.dart';
import 'package:http/http.dart' as http;


Future<int> postReply(int thread_id, String message) async {
  var response = await http.post('https://tapple.world/api/posts/',
    body: {
      'thread_id': thread_id.toString(), 'message': message
    },
    headers: {
      "XF-Api-Key": API_KEY_POST,
      "XF-Api-User": globalUser == null ? "" : "${globalUser.user_id}",
    },
  );
  return response.statusCode;

}