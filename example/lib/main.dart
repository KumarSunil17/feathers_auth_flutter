import 'dart:developer';
import 'dart:async';
import 'package:feathers_auth_flutter/feathers_auth_flutter.dart';
import 'package:feathers_auth_flutter_example/gender_response.dart';

Future<void> main() async {
  ///
  /// Initialize app with your base url and authentication configs if any
  ///
  FlutterFeathersApp app = FlutterFeathersApp(
    "http://192.168.29.241:3030",
  );

  app.initialize();

  ///
  /// If you need to access any other api rather than your base url
  /// app.rawDio you provide you raw Dio client without access token attached to header
  ///
  // final res = await app.rawDio.get<String>('<any outside urls>');
  // log('RAW GET ${res.data}');

  ///
  /// Create you service providing service path
  ///
  final FlutterFeatherService userService =
      app.service('/v1/masterdata/gender-master');
  final FlutterFeatherService messageService =
      app.service('/v1/chat/personal-chat/messages');
  final FlutterFeatherService getMessageSocket =
  app.service('v1/message-recipients');

  ///
  /// Get response from service
  ///
  final usersRes = await userService.get<GenderResponse>(decoder: (data) {
    return GenderResponse.fromJson(data);
  });
  print('USER SERVICE GET ${usersRes.data}');

  ///
  /// Socket implementation
  ///

  await getMessageSocket.connectSocket().then((c) async {
    await getMessageSocket.emitWithAck(
      "create",
      [
        "authentication",
        {
          "deviceId": "ewrfysfetfhgfdgddhtsdfrerdwrfgufnjweihrufihruhdfuewjiojojfdqr",
          "deviceType": "2",
          "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJzdWIiOjIyMCwiaWF0IjoxNzU0NTUyNjc4LCJleHAiOjE3NTcxNDQ2NzgsImF1ZCI6Imh0dHBzOi8veW91cmRvbWFpbi5jb20iLCJpc3MiOiJmZWF0aGVycyIsImp0aSI6IjQyMzQzODM0LWRhZjQtNDdjYy1iZGU0LWNjY2Y0MjUxODM2OCJ9.e7f88Npykl3jVR4cmwapGaETDuekylRUoYb2Is6l2CU",
          "strategy": "jwt",
          "fcmId": "sahjadhdhsadhsadsds",
        }
      ],
    ).then((e) async {
      app.setAccessToken( "eyJhbGciOiJIUzI1NiIsInR5cCI6ImFjY2VzcyJ9.eyJzdWIiOjIyMCwiaWF0IjoxNzU0NTUyNjc4LCJleHAiOjE3NTcxNDQ2NzgsImF1ZCI6Imh0dHBzOi8veW91cmRvbWFpbi5jb20iLCJpc3MiOiJmZWF0aGVycyIsImp0aSI6IjQyMzQzODM0LWRhZjQtNDdjYy1iZGU0LWNjY2Y0MjUxODM2OCJ9.e7f88Npykl3jVR4cmwapGaETDuekylRUoYb2Is6l2CU",);
    });
  });



  getMessageSocket.on("created", (data) {
    print("NEW_MESSAGE ${data}");
  });

  // messageService.create(body: {
  //     "entityType": "userGroup",
  //     "recipient": "678f40a3f48861514cf87948",
  //     "text": "hey,there",
  //   },
  //   );
  final socketRes = await getMessageSocket.emit('create', {
    "entityType": "userGroup",
    "recipient": "678f40a3f48861514cf87948",
    "text": "hey,there",
  });
  print("SOCKET EMIT RESPONSE ${socketRes}");
}
