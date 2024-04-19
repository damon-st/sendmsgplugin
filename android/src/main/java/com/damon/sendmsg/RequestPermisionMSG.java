package com.damon.sendmsg;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.logging.Logger;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class RequestPermisionMSG implements PluginRegistry.RequestPermissionsResultListener {
    private static final int PERMISSION_REQUEST_CODE = 123;
    private static  final String TAG ="sendMsg";
    private MethodChannel.Result result;

    public void onRequestPermision(MethodChannel.Result result, Activity activity){
        this.result=result;
        if(Build.VERSION.SDK_INT>= Build.VERSION_CODES.M && activity.checkSelfPermission(Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED){
            activity.requestPermissions(new String[]{Manifest.permission.SEND_SMS,Manifest.permission.READ_PHONE_STATE},PERMISSION_REQUEST_CODE);
        }else{
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                result.success(activity.checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED);
            }else{
                result.success(false);
            }
        }
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        Log.i(TAG,"onRequestPermissionsResult"+requestCode);
        if(requestCode == PERMISSION_REQUEST_CODE){
            if(grantResults.length>0 && grantResults[0]== PackageManager.PERMISSION_GRANTED){
                if(result!=null){
                    result.success(true);
                }
                return  true;
            }
        }
        if(result!=null){
            result.success(false);
        }
        return false;
    }
}
