package com.damon.sendmsg;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import androidx.core.app.ActivityCompat;


public class RequestPermisionMSG implements PluginRegistry.RequestPermissionsResultListener,PluginRegistry.ActivityResultListener {

    private static final int PERMISSION_REQUEST_CODE = 123;
    private static  final String TAG ="sendMsg";
    private MethodChannel.Result result;

    private  Activity activity;

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public void onRequestPermision(MethodChannel.Result result, Activity activity){
        this.result=result;
        if(Build.VERSION.SDK_INT>= Build.VERSION_CODES.M && activity.checkSelfPermission(Manifest.permission.SEND_SMS) != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(activity,new String[]{Manifest.permission.SEND_SMS,Manifest.permission.READ_PHONE_STATE},PERMISSION_REQUEST_CODE);
            result.success(false);
        }else{
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                result.success(activity.checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED);
            }else{
                result.success(false);
            }
        }
    }

    public void onCheckStatusPermission(MethodChannel.Result result){
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            boolean r =activity.checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED && activity.checkSelfPermission(Manifest.permission.READ_PHONE_STATE)==PackageManager.PERMISSION_GRANTED;
            result.success(r);
        }else{
            result.success(true);
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

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        Log.i(TAG,"onRequestPermissionsResult"+requestCode+resultCode);

        if(resultCode== PERMISSION_REQUEST_CODE && result !=null && activity !=null){
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
                boolean r =activity.checkSelfPermission(Manifest.permission.SEND_SMS) == PackageManager.PERMISSION_GRANTED;
                result.success(r);
                return  true;
            }
        }
        if(result!=null){
            result.success(false);
        }
        return false;
    }
}
