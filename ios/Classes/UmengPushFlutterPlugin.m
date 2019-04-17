#import "UmengPushFlutterPlugin.h"
#import <umeng_push_flutter_plugin/umeng_push_flutter_plugin-Swift.h>

@implementation UmengPushFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUmengPushFlutterPlugin registerWithRegistrar:registrar];
}
@end
