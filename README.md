# feathers_auth_flutter

Feathers client for Dart

## Features
- Automatically stores access token to shared preference
- Re-authenticate app if access token expires
- Custom service
- Access to handle other outside api calls

## Get Started

### Add dependency

```yaml
dependencies:
  feathers_auth_flutter: #latest version
```

### Import plugin class to your file
```dart
import 'package:feathers_auth_flutter/feathers_auth_flutter.dart';
```

### Initialize
```dart
final FlutterFeathersApp app = FlutterFeathersApp('<base url>',
    authConfig: AuthConfig('<authen tication path>',
        authMode: AuthMode.authenticateOnExpire,
        sharedPrefKey: 'accessToken'));

app.initialize();
```

### Authenticate (if required)
```dart
app.authenticate(body: {}, queryParameters: {});
```

### Re-authenticate (if required)
```dart
app.reAuthenticate(AuthMode.authenticateOnExpire);
```

### Create a service
```dart
final FlutterFeatherService userService = app.service('users');
```

### Access your service methods
```dart
final usersRes = await userService.get<String>();
log('USER SERVICE GET ${usersRes.data}');
```

### Additional : Any other apis
```dart
final res = await app.rawDio.get<String>('<any outside urls>');
log('RAW GET ${res.data}');
```

### For connect a socket
```dart
 final FlutterFeatherService getMessageSocket =
app.service('v1/message-recipients');
final res = await getMessageSocket.connect();
```

### For receive data from socket
```dart
 getMessageSocket.on("created", (data) {
    print("NEW_MESSAGE ${data}");
  });
```

### To send data in socket
```dart
final socketRes = await getMessageSocket.emit('create', {
    "entityType": "userGroup",
    "recipient": "678f40a3f48861514cf87948",
    "text": "hey,there",
  });
  print("SOCKET EMIT RESPONSE ${socketRes}");
```