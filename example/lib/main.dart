import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:umeng_push_flutter_plugin/umeng_push_flutter_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _registerResult;

  @override
  void initState() {
    super.initState();

    UmengPushFlutterPlugin.getChannel()
        .setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'registeUmengPushCallback':
          print("注册友盟推送的结果是:${call.arguments}");
          if (!mounted) return;
          setState(() {
            _registerResult = call.arguments;
          });
          break;
        default:
          throw MissingPluginException();
      }
    });

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await UmengPushFlutterPlugin.initUmengPush;
    } on PlatformException {
      setState(() {
        _registerResult = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('友盟flutter推送plugin_示例'),
        ),
        body: Center(
          child: Text('友盟推送注册结果: $_registerResult'),
        ),
      ),
    );
  }
}
