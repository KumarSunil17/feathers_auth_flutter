part of feathers_client_flutter;

enum RequestMethod { get, post, patch, delete }

abstract class FeathersService {
  ///
  /// Required FeathersApp
  ///
  FlutterFeathersApp app;

  ///
  /// Path for custom service
  ///
  String servicePath;

  FeathersService(
    this.app,
    this.servicePath,
  );

  ///
  /// Full path/url for api calls
  ///
  String get path => app.baseUrl + path;

  ///
  /// GET method request with optional queryParameters
  ///
  Future<Response<T>> get<T>(
      {Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// FIND method request with required id and optional queryParameters
  ///
  Future<Response<T>> find<T>(String id,
      {Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// CREATE method request with and optional body and query Parameters
  ///
  Future<Response<T>> create<T>(
      {dynamic body = const {},
      Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// FIND method request with required id and optional queryParameters
  ///
  Future<Response<T>> update<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// PATCH method request with required id and optional queryParameters
  ///
  Future<Response<T>> patch<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// DELETE method request with required id and optional queryParameters
  ///
  Future<Response<T>> delete<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters,
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers});

  ///
  /// Connect to the socket server
  ///
  Future connectSocket();

  ///
  /// Emit an event with optional data
  ///
  Future emit(String event, dynamic data);

  ///
  /// Emit an event with acknowledgment callback
  ///
  Future emitWithAck(String event, dynamic data);

  ///
  /// Listen to a socket event
  ///
  void on(String event, Function(dynamic data) callback);

  ///
  /// Remove a socket event listener
  ///
  void off(String event);

  Response<T> transformResponse<T>(Response response, T data) {
    return Response<T>(
      data: data,
      headers: response.headers,
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      redirects: response.redirects,
      isRedirect: response.isRedirect,
      extra: response.extra,
    );
  }
}

class FlutterFeatherService extends FeathersService {
  FlutterFeathersApp app;
  String servicePath;

  FlutterFeatherService(this.app, this.servicePath) : super(app, servicePath);

  @override
  String get path => app.baseUrl + servicePath;

  socketClient.Socket get socket => app._socket;

  @override
  Future<Response<T>> get<T>(
      {Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await app._dio.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));

      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error, s) {
      throw _handleError(error);
    }
  }

  @override
  Future<Response<T>> find<T>(String id,
      {Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await app._dio.get('$path/$id',
          queryParameters: queryParameters, options: Options(headers: headers));
      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<Response<T>> create<T>(
      {dynamic body = const {},
      Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await app._dio.post(path,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<Response<T>> update<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await app._dio.patch('$path/$id',
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<Response<T>> patch<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response response = await app._dio
          .patch('$path/$id', data: body, queryParameters: queryParameters);
      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<Response<T>> delete<T>(String id,
      {dynamic body = const {},
      Map<String, dynamic> queryParameters = const {},
      T Function(dynamic data)? decoder,
      Map<String, dynamic>? headers}) async {
    try {
      final Response<T> response =
          await app._dio.delete('$path/$id', queryParameters: queryParameters);
      if (decoder != null) {
        final T decodedData = decoder(response.data);
        return transformResponse(response, decodedData);
      }
      return transformResponse(response, response.data as T);
    } catch (error) {
      throw _handleError(error);
    }
  }

  Object _handleError<T>(error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.badCertificate:
          return FeathersError.noInternet(
              result: false,
              name: "Bad Certificate",
              message: "SSL error",
              code: null,
              isRestError: false);

        case DioExceptionType.badResponse:
          return FeathersError.fromJson(error.response!.data);

        case DioExceptionType.cancel:
          return FeathersError(
            isRestError: false,
            code: null,
            message: 'Canceled',
            name: 'Cancel',
            result: false,
          );

        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return FeathersError.noInternet(code: null);
        case DioExceptionType.unknown:
          return FeathersError(
              isRestError: false,
              code: 0,
              message: error.response?.data,
              name: error.message,
              result: false);
      }
    } else {
      return FeathersError(
          message: error.toString(), name: 'Some error occurred');
    }
  }

  @override
  Future connectSocket() async {
    final completer = Completer<dynamic>();
    socket.connect();
    socket.onConnectError((e) {
      print("ON_SOCKET_CONNECT_ERROR ${e}");
      completer.completeError('Socket not connected');
    });
    socket.onConnect((e) {
      completer.complete(e);
      print("ON_SOCKET_CONNECT  ${e}");
    });

    socket.onDisconnect((e) {
      completer.complete(e);
      print("ON_SOCKET_DISCONNECT  ${e}");
    });
    return completer.future;
  }

  @override
  Future emit(String event, dynamic data) {
    final completer = Completer<dynamic>();

    if (socket.connected) {
      socket.emit(servicePath + " " + event, data);
      completer.complete(data);
    } else {
      completer.completeError('Socket not connected');
    }

    return completer.future;
  }

  Future<dynamic> emitWithAck(String event, dynamic data) async {
    final completer = Completer<dynamic>();

    if (socket.connected) {
      socket.emitWithAck(servicePath + " " + event, data, ack: (response) {
        completer.complete(response);
      });
    } else {
      completer.completeError('Socket not connected');
    }

    return completer.future;
  }

  @override
  void on(String event, Function(dynamic data) callback) {
    socket.on(servicePath + " " + event, callback);
  }

  @override
  void off(String event) {
    socket.off(servicePath + " " + event);
  }
}
