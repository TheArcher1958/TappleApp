import 'package:tappleapp/Globals.dart';
import 'package:http/http.dart' as http;


Future<List<dynamic>> getLogin(storage) async {
  var tapUser = await storage.read(key: "tappleUsername");
  var tapPass = await storage.read(key: "tapplePassword");

  return [tapUser, tapPass];
}

Future<int> postReply(int thread_id, String message) async {
  var loginInfo = await getLogin(storage);
  var response = await http.post('https://tapple.world/archers_testing/mobile/mobilePostToForums.php',
    body: {
      'XF-Thread-ID': thread_id.toString(), 'XF-Reply-Message': message
      , 'XF-Username': loginInfo[0], 'XF-Password': loginInfo[1], 'XF-Task': "replyToPost"
    },
  );
  return response.statusCode;
}




