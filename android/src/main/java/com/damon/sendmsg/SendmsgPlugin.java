package com.damon.sendmsg;

import android.app.Activity;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** SendmsgPlugin */
public class SendmsgPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private RequestPermisionMSG requestPermisionMSG = new RequestPermisionMSG();
  private SendMsg sendMsg = new SendMsg();

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "sendmsg");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    }else if(call.method.equals("requestPermission")){
        requestPermisionMSG.onRequestPermision(result,activity);
    }else if(call.method.equals("sendMsg")){
        Map<String,Object> arg = (Map<String, Object>)call.arguments;
        String phone = (String)arg.get("phone");
        String msg = (String)arg.get("msg");
        int slotIndex = 0;

        Object exist=  arg.get("slotIndex");
        if(exist!=null){
          slotIndex = (int) exist;
        }

        sendMsg.sendMessage(activity,result,phone,msg,slotIndex);
    }else if(call.method.equals("sendMsgSingle")){
      Map<String,Object> arg = (Map<String, Object>)call.arguments;
      String phone = (String)arg.get("phone");
      String msg = (String)arg.get("msg");
      sendMsg.sendMsgSingleSim(result,activity,phone,msg);
    }else if(call.method.equals("getAllSims")){
      sendMsg.getAllSims(activity,result);
    }else if(call.method.equals("checkStatusPermission")){
      requestPermisionMSG.onCheckStatusPermission(result);
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
    requestPermisionMSG.setActivity(activity);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
  activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
  activity = binding.getActivity();
    requestPermisionMSG.setActivity(activity);
  }

  @Override
  public void onDetachedFromActivity() {

  }
}
