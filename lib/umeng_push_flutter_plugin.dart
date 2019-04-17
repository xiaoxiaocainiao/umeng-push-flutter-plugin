import 'dart:async';

import 'package:flutter/services.dart';

class UmengPushFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('umeng_push_flutter_plugin');

  static MethodChannel getChannel() {
    return _channel;
  }

  static Future<dynamic> get initUmengPush async {
    await _channel.invokeMethod('initUmengPush');
  }
}
