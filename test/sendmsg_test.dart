import 'package:flutter_test/flutter_test.dart';
import 'package:sendmsg/sendmsg.dart';
import 'package:sendmsg/sendmsg_platform_interface.dart';
import 'package:sendmsg/sendmsg_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSendmsgPlatform
    with MockPlatformInterfaceMixin
    implements SendmsgPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
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
