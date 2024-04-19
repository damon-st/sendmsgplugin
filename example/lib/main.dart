import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sendmsg/sendmsg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _sendmsgPlugin = Sendmsg();

  final TextEditingController txtNumber = TextEditingController();
  final TextEditingController txtMsg = TextEditingController();
  String msg = "";
  bool sending = false;
  List sims = [];
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    txtNumber.dispose();
    txtMsg.dispose();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _sendmsgPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void onPermision() async {
    try {
      final result = await _sendmsgPlugin.requestPermision();
      debugPrint("[RESULT_onPermision]$result");
    } catch (e) {
      debugPrint("[ERROR_onPermision]$e");
    }
  }

  void onSendMsg() async {
    try {
      if (sending) return;
      sending = true;
      final result =
          await _sendmsgPlugin.sendMsg(phone: txtNumber.text, msg: txtMsg.text);
      debugPrint("[RESULT_onSendMsg]$result");
      sending = false;
      if (result == null) return;
      setState(() {
        msg = result ? "Mensaje enviado" : "Error al enviar";
      });
      sending = false;
    } catch (e) {
      sending = false;
      debugPrint("[ERROR_onSendMsg]$e");
    }
  }

  void onSendMsgSingle() async {
    try {
      if (sending) return;
      sending = true;
      final result = await _sendmsgPlugin.sendMsgSingle(
          phone: txtNumber.text, msg: txtMsg.text);
      debugPrint("[RESULT_onSendMsg]$result");
      sending = false;
      if (result == null) return;
      setState(() {
        msg = result ? "Mensaje enviado" : "Error al enviar";
      });
      sending = false;
    } catch (e) {
      sending = false;
      debugPrint("[ERROR_onSendMsg]$e");
    }
  }

  void getAllSims() async {
    try {
      sims = [];
      sims = await _sendmsgPlugin.getAllSims();
      setState(() {});
    } catch (e) {
      debugPrint("[ERROR_METHOD_getAllSims]$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            ElevatedButton(
                onPressed: onPermision, child: Text("Request Permission msg")),
            const SizedBox(
              height: 10,
            ),
            const Text("Numero"),
            TextField(
              controller: txtNumber,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Mensaje"),
            TextField(
              controller: txtMsg,
            ),
            Text(
              msg,
            ),
            ElevatedButton(onPressed: onSendMsgSingle, child: Text("Send msg")),
            ElevatedButton(onPressed: getAllSims, child: Text("Get all sims")),
            Expanded(
                child: ListView.builder(
              itemCount: sims.length,
              itemBuilder: (c, i) {
                final sim = sims[i];
                return Text("$sim");
              },
            ))
          ],
        ),
      ),
    );
  }
}
