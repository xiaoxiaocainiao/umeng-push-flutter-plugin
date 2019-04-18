import Flutter
import UIKit

var channel: FlutterMethodChannel?

public class SwiftUmengPushFlutterPlugin: NSObject, FlutterPlugin {

    public static var launchOptions: NSDictionary?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "umeng_push_flutter_plugin", binaryMessenger: registrar.messenger())
    if let channelValue = channel  {
        let instance = SwiftUmengPushFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channelValue)
    }
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "initUmengPush") {
    }
  }
}
