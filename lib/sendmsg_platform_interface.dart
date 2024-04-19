import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sendmsg/models/sim_info.dart';

import 'sendmsg_method_channel.dart';

abstract class SendmsgPlatform extends PlatformInterface {
  /// Constructs a SendmsgPlatform.
  SendmsgPlatform() : super(token: _token);

  static final Object _token = Object();

  static SendmsgPlatform _instance = MethodChannelSendmsg();

  /// The default instance of [SendmsgPlatform] to use.
  ///
  /// Defaults to [MethodChannelSendmsg].
  static SendmsgPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SendmsgPlatform] when
  /// they register themselves.
  static set instance(SendmsgPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> requestPermision() {
    throw UnimplementedError('requestPermision() has not been implemented.');
  }

  Future<bool?> sendMsg({
    required String phone,
    required String msg,
  }) {
    throw UnimplementedError('sendMsg() has not been implemented.');
  }

  Future<bool?> sendMsgSingle({
    required String phone,
    required String msg,
  }) {
    throw UnimplementedError('sendMsgSingle() has not been implemented.');
  }

  Future<List<SimInfoM>> getAllSims() {
    throw UnimplementedError('getAllSims() has not been implemented.');
  }
}
