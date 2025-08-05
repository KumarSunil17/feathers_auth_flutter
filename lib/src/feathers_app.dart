part of feathers_auth_flutter;

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

  FeathersApp(this.baseUrl);

  ///
  /// Configure app using base url
  ///
  void initialize();

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
  }

  ///
  /// Returns a FeatherService with provided path
  /// included access token in header of Dio client
  ///
  @override
  FlutterFeatherService service(String path) {
    return FlutterFeatherService(this, path, _dio);
  }

  ///
  /// Raw dio client for other api calls
  ///
  Dio get rawDio => _dio;
}
