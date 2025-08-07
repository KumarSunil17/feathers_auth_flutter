part of feathers_client_flutter;

abstract class FeathersApp {
  ///
  /// Base url
  ///
  String baseUrl;

  ///
  /// Dio client
  ///
  late Dio _dio;
  late IO.Socket io;
  late socketClient.Socket _socket;

  FeathersApp(this.baseUrl);

  ///
  /// Configure app using base url
  ///
  void initialize();
  void setAccessToken(String token);

  FlutterFeatherService service(String path);
}

///
/// Implementation of FeathersApp
///
class FlutterFeathersApp extends FeathersApp {
  FlutterFeathersApp(String baseUrl) : super(baseUrl);

  @override
  void initialize() {
    _dio = Dio();
    super._dio = _dio;
    _socket = socketClient.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnect': true
    });
    super._socket = _socket;
  }

  @override
  void setAccessToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  ///
  /// Returns a FeatherService with provided path
  /// included access token in header of Dio client
  ///
  @override
  FlutterFeatherService service(String path) {
    return FlutterFeatherService(this, path);
  }

  ///
  /// Raw dio client for other api calls
  ///
  Dio get rawDio => _dio;
}
