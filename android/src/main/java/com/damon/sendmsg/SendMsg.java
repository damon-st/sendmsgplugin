package com.damon.sendmsg;


import android.app.Activity;
import android.os.Build;
import android.telephony.SmsManager;
import android.telephony.SubscriptionInfo;
import android.telephony.SubscriptionManager;
import android.content.Context;
import android.util.Log;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;


public class SendMsg {

    private static  final String TAG ="sendMsgClass";

    public void getAllSims(Activity activity, MethodChannel.Result result){
        List<Map<String,Object>> tempList=new ArrayList<>();
        try{
            SubscriptionManager subscriptionManager = null;
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                subscriptionManager = SubscriptionManager.from(activity.getApplicationContext());
            }

            // Verificar si la función SubscriptionManager está disponible
            if (subscriptionManager != null) {
                // Obtener la lista de información de las tarjetas SIM
                List<SubscriptionInfo> subscriptionInfoList = null;
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                    subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();
                }
                // Verificar si hay información de tarjeta SIM disponible
                if (subscriptionInfoList != null && !subscriptionInfoList.isEmpty()) {
                    // Obtener la información de la primera tarjeta SIM
                    for (SubscriptionInfo s:subscriptionInfoList
                    ) {
                        Map<String,Object> data = new HashMap<>();
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                            data.put("number",s.getNumber());
                            data.put("country",s.getCountryIso());
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                                data.put("mcc",s.getMccString());
                                data.put("cardId",s.getCardId());
                                data.put("carrierId",s.getCarrierId());
                                data.put("groupUuid",s.getGroupUuid());
                                data.put("mncStr",s.getMncString());
                                data.put("subscriptionType",s.getSubscriptionType());

                            }
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                                data.put("portIndex",s.getPortIndex());
                                data.put("usageSetting",s.getUsageSetting());
                            }

                            data.put("slotIndex",s.getSimSlotIndex());
                            data.put("roamingData",s.getDataRoaming());
                            data.put("carrierName",s.getCarrierName().toString());
                            data.put("displayName",s.getDisplayName().toString());
                            data.put("iccId",s.getIccId());
                            data.put("mccInt",s.getMcc());
                            data.put("subscriptionId",s.getSubscriptionId());
                        }
                        tempList.add(data);
                    }
                    result.success(tempList);
                } else {
                    throw  new Exception("No se encontró información de la tarjeta SIM");
                }
            } else {
                throw  new Exception("La función SubscriptionManager no está disponible en este dispositivo");
            }
        }catch (Exception e){
            Log.i(TAG,"ERROR:"+e.getMessage());
            result.success(tempList);
        }
    }

    public void sendMessage(Activity activity, MethodChannel.Result result,String phone,String msg) {
       try {
           // Obtener una instancia de SubscriptionManager

           SubscriptionManager subscriptionManager = null;
           if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
               subscriptionManager = SubscriptionManager.from(activity.getApplicationContext());
           }

           // Verificar si la función SubscriptionManager está disponible
           if (subscriptionManager != null) {
               // Obtener la lista de información de las tarjetas SIM
               List<SubscriptionInfo> subscriptionInfoList = null;
               if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                   subscriptionInfoList = subscriptionManager.getActiveSubscriptionInfoList();
                   for (SubscriptionInfo s:subscriptionInfoList
                        ) {
                       String infoS = "NUMBER:"+s.getNumber()+"\n";
                       infoS+="Country:"+s.getCountryIso()+"\n";
                       infoS+="SIM_SLOT:"+s.getSimSlotIndex()+"\n";
                       if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                           infoS+="MCC:"+s.getMccString()+"\n";
                       }
                       Log.i(TAG,"SUBSCRIPTION_LIST:"+infoS);
                   }
               }

               // Verificar si hay información de tarjeta SIM disponible
               if (subscriptionInfoList != null && !subscriptionInfoList.isEmpty()) {
                   // Obtener la información de la primera tarjeta SIM
                   SubscriptionInfo subscriptionInfo = subscriptionInfoList.get(0);

                   // Obtener el id de la tarjeta SIM seleccionada
                   int subscriptionId = 0;
                   if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
                       subscriptionId = subscriptionInfo.getSubscriptionId();
                       // Obtener una instancia de SmsManager
                       SmsManager smsManager = SmsManager.getSmsManagerForSubscriptionId(subscriptionId);

                       // Número de teléfono al que quieres enviar el mensaje
                       String phoneNumber = phone;

                       // Mensaje que quieres enviar
                       String message = msg;

                       // Enviar el mensaje utilizando la tarjeta SIM seleccionada
                       smsManager.sendTextMessage(phoneNumber, null, message, null, null);
                       result.success(true);
                   }
                   result.success(false);
               } else {
                   Toast.makeText(activity, "No se encontró información de la tarjeta SIM", Toast.LENGTH_SHORT).show();
                   result.success(false);
               }
           } else {
               Toast.makeText(activity, "La función SubscriptionManager no está disponible en este dispositivo", Toast.LENGTH_SHORT).show();
               result.success(false);
           }
           result.success(false);
       }catch (Exception e){
           Log.i(TAG,"ERROR:"+e.getMessage());
           result.success(false);
       }
    }

    public   void sendMsgSingleSim(MethodChannel.Result result,Activity activity,String phone,String msg){
        try{
            // Obtener una instancia de SmsManager
            SmsManager smsManager = SmsManager.getDefault();

            // Número de teléfono al que quieres enviar el mensaje
            String phoneNumber = phone;

            // Mensaje que quieres enviar
            String message = msg;

            // Enviar el mensaje
            smsManager.sendTextMessage(phoneNumber, null, message, null, null);
            result.success(true);
        }catch (Exception e){
            Log.i(TAG,"ERROR:"+e.getMessage());
            result.success(false);
        }
    }
}
