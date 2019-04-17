package im.wangyan.umeng_push_flutter_plugin;

import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.umeng.commonsdk.UMConfigure;
import com.umeng.message.IUmengRegisterCallback;
import com.umeng.message.PushAgent;
import com.umeng.message.UmengMessageHandler;
import com.umeng.message.entity.UMessage;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;


/**
 * UmengPushFlutterPlugin
 */
public class UmengPushFlutterPlugin implements MethodCallHandler {

    private static String TAG = UmengPushFlutterPlugin.class.getName();

    static MethodChannel channel;

    public static void registerWith(Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), "umeng_push_flutter_plugin");
        channel.setMethodCallHandler(new UmengPushFlutterPlugin(registrar.context().getApplicationContext()));
    }

    private final Context mContext;

    private UmengPushFlutterPlugin(Context context) {
        mContext = context;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("initUmengPush")) {
            Handler mainHandler = new Handler(Looper.getMainLooper());
            mainHandler.post(new Runnable() {
                @Override
                public void run() {
                    initUmengPush(mContext);
                }
            });
        } else {
            result.notImplemented();
        }
    }

    private void initUmengPush(Context context) {
        UMConfigure.setLogEnabled(BuildConfig.DEBUG);
        UMConfigure.init(context, "5cb7271d61f5644ed700060b", "channel", UMConfigure.DEVICE_TYPE_PHONE, "e982b8e8c191fc39b173051b7ef30634");

        //获取消息推送代理示例
        PushAgent mPushAgent = PushAgent.getInstance(context);
        //注册推送服务，每次调用register方法都会回调该接口
        mPushAgent.register(new IUmengRegisterCallback() {
            @Override
            public void onSuccess(String deviceToken) {
                //注册成功会返回deviceToken deviceToken是推送消息的唯一标志
                Log.d(TAG, "注册成功：deviceToken：-------->  " + deviceToken);
                channel.invokeMethod("registerUmengPushCallback", true);
            }

            @Override
            public void onFailure(String s, String s1) {
                Log.d(TAG, "注册失败：-------->  " + "s:" + s + ",s1:" + s1);
                channel.invokeMethod("registerUmengPushCallback", false);
            }
        });
        mPushAgent.setMessageHandler(messageHandler);
    }

    UmengMessageHandler messageHandler = new UmengMessageHandler() {

        @Override
        public void dealWithCustomMessage(Context context, UMessage uMessage) {
            super.dealWithCustomMessage(context, uMessage);
            Log.d(TAG, "uMessage:" + uMessage.toString());
        }
    };

}
