import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sendmsg/models/sim_info.dart';

import 'sendmsg_platform_interface.dart';

/// An implementation of [SendmsgPlatform] that uses method channels.
class MethodChannelSendmsg extends SendmsgPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sendmsg');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> requestPermision() async {
    final result = await methodChannel.invokeMethod<bool>("requestPermission");
    return result;
  }

  @override
  Future<bool?> sendMsg({required String phone, required String msg}) async {
    final result = await methodChannel
        .invokeMethod<bool>("sendMsg", {"phone": phone, "msg": msg});
    return result;
  }

  @override
  Future<bool?> sendMsgSingle(
      {required String phone, required String msg}) async {
    final result = await methodChannel
        .invokeMethod<bool>("sendMsgSingle", {"phone": phone, "msg": msg});
    return result;
  }

  @override
  Future<List<SimInfoM>> getAllSims() async {
    try {
      final result = await methodChannel.invokeMethod<List>("getAllSims");
      return (result ?? []).map((e) => SimInfoM.fromMap(Map.from(e))).toList();
    } catch (e) {
      if (kDebugMode) {
        print("[ERROR_getAllSims]$e");
      }
      return [];
    }
  }
}
