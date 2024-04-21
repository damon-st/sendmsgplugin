import 'package:flutter_test/flutter_test.dart';
import 'package:sendmsg/models/sim_info.dart';
import 'package:sendmsg/sendmsg.dart';
import 'package:sendmsg/sendmsg_platform_interface.dart';
import 'package:sendmsg/sendmsg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSendmsgPlatform
    with MockPlatformInterfaceMixin
    implements SendmsgPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool> checkStatusPermission() => Future.value(true);

  @override
  Future<List<SimInfoM>> getAllSims() => Future.value([]);

  @override
  Future<bool?> requestPermision() => Future.value(true);

  @override
  Future<bool?> sendMsg(
          {required String phone, required String msg, int slotIndex = 0}) =>
      Future.value(true);

  @override
  Future<bool?> sendMsgSingle({required String phone, required String msg}) =>
      Future.value(true);
}

void main() {
  final SendmsgPlatform initialPlatform = SendmsgPlatform.instance;

  test('$MethodChannelSendmsg is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSendmsg>());
  });

  test('getPlatformVersion', () async {
    Sendmsg sendmsgPlugin = Sendmsg();
    MockSendmsgPlatform fakePlatform = MockSendmsgPlatform();
    SendmsgPlatform.instance = fakePlatform;

    expect(await sendmsgPlugin.getPlatformVersion(), '42');
  });
}
