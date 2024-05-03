import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

final Map<String, String> _mockSecureStorage = <String, String>{};
void setupMockFlutterSecureStorage() {
  const channel = MethodChannel('plugins.it_nomads.com/flutter_secure_storage');
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'delete') {
      _mockSecureStorage.remove(methodCall.arguments['key'] as String);
    } else if (methodCall.method == 'write') {
      _mockSecureStorage[methodCall.arguments['key'] as String] =
          methodCall.arguments['value'] as String;
    } else if (methodCall.method == 'read') {
      return _mockSecureStorage[methodCall.arguments['key'] as String];
    }
    return null;
  });
}

void setupMockPathProvider() {
  const channel = MethodChannel('plugins.flutter.io/path_provider');
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'getApplicationDocumentsDirectory') {
      return '/tmp/saber-test-docs';
    } else if (methodCall.method == 'getTemporaryDirectory') {
      return '/tmp/saber-test-tmp';
    }
    return null;
  });
}

void setupMockPrinting() {
  const channel = MethodChannel('net.nfet.printing');
  TestWidgetsFlutterBinding.ensureInitialized();
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'printingInfo') {
      return {}; // [PrintingInfo.unavailable]
    }
    return null;
  });
}

void setupMockAudioplayers() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('xyz.luan/audioplayers');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'create') {
      return true;
    }
    return null;
  });

  const playerChannel =
      MethodChannel('xyz.luan/audioplayers/events/pencilSoundEffect');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(playerChannel, (MethodCall methodCall) async {
    if (methodCall.method == 'listen') {
      return true;
    }
    return null;
  });
}
