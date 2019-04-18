#import "UmengPushFlutterPlugin.h"

#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

@implementation UmengPushFlutterPlugin
{
    NSDictionary *_launchOptions;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {

    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"umeng_push_flutter_plugin"
              binaryMessenger:[registrar messenger]];

    UmengPushFlutterPlugin* instance = [[UmengPushFlutterPlugin alloc] init];
    instance.channel = channel;


    [registrar addApplicationDelegate:instance];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initUmengPush" isEqualToString:call.method]) {
    [self initUmengPush];
  } else{
    result(FlutterMethodNotImplemented);
  }
}


-(void)initUmengPush {
    [UMConfigure initWithAppkey:@"5cb8074a3fc195332c000559" channel:@"wangyan"];
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=UIApplication.sharedApplication;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:_launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
        NSLog(@"注册结果: %d",granted);
        NSNumber *result = [NSNumber numberWithBool:granted];
        [_channel invokeMethod:@"registeUmengPushCallback" arguments:result];
    }];
}

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _launchOptions = launchOptions;
    return YES;
}
@end
