import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendAndRetrieveMessage(
    {required String title,
    required String message,
    // required String token}) async {
    required List<String> tokins}) async {
  // Go to Firebase console -> Project settings -> Cloud Messaging -> copy Server key
  // the Server key will start "AAAAMEjC64Y..."

  final yourServerKey =
      "AAAANWzLWAY:APA91bEIZNtY7jxFi-q1UoMKDT1ORzJ2w3-pMOwDJpTeLzUyVtVNGlSV2rIvCp_QBI0_YWv880lSRVMsNFgipFHs4Zk5LkvuhwDzUk1EYNtOiTXR7IEfxbMEbxIEq_WLvtko63CdMjD4";
  var response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$yourServerKey',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': "${message}",
          'title': '${title}',
          // 'image':
          //     'https://yt3.ggpht.com/ytc/AAUvwnjuH8xEOYQyRAE2NMrVieRw0GBbcJ9l5wLPpvgHDQ=s88-c-k-c0x00ffffff-no-rj'
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        // FCM Token lists.
        'registration_ids': tokins.map((e) => "${e}").toList(),
        // 'to': token
      },
    ),
  );
  print(response.body);
}
