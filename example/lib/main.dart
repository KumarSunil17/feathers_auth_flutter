import 'dart:developer';
import 'dart:async';
import 'package:feathers_auth_flutter/feathers_auth_flutter.dart';

Future<void> main() async {
  ///
  /// Initialize app with your base url and authentication configs if any
  ///
  FlutterFeathersApp app = FlutterFeathersApp(
    "",
  );

  app.initialize();

  ///
  /// If you need to access any other api rather than your base url
  /// app.rawDio you provide you raw Dio client without access token attached to header
  ///
  final res = await app.rawDio.get<String>('<any outside urls>');
  log('RAW GET ${res.data}');

  ///
  /// Create you service providing service path
  ///
  final FlutterFeatherService userService = app.service('users');

  ///
  /// Get response from service
  ///
  final usersRes = await userService.get<String>();
  log('USER SERVICE GET ${usersRes.data}');
}
