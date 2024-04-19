import 'package:sendmsg/models/sim_info.dart';

import 'sendmsg_platform_interface.dart';

class Sendmsg {
  Future<String?> getPlatformVersion() {
    return SendmsgPlatform.instance.getPlatformVersion();
  }

  Future<bool?> requestPermision() =>
      SendmsgPlatform.instance.requestPermision();
  Future<bool?> sendMsg({
    required String phone,
    required String msg,
  }) =>
      SendmsgPlatform.instance.sendMsg(phone: phone, msg: msg);
  Future<bool?> sendMsgSingle({
    required String phone,
    required String msg,
  }) =>
      SendmsgPlatform.instance.sendMsgSingle(phone: phone, msg: msg);

  Future<List<SimInfoM>> getAllSims() => SendmsgPlatform.instance.getAllSims();
}
