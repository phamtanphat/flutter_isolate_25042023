import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

class DemoIsolateWidget extends StatefulWidget {
  const DemoIsolateWidget({Key? key}) : super(key: key);

  @override
  State<DemoIsolateWidget> createState() => _DemoIsolateWidgetState();
}

class _DemoIsolateWidgetState extends State<DemoIsolateWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Isolate"),
      ),
      body: Container(
        child: Column(
          children: [
            CircularProgressIndicator(),
            ElevatedButton(onPressed: () {
              doSomething().then((value) => print(value));
            }, child: Text("Make heavy task"))
          ],
        ),
      ),
    );
  }

  static void makeHeavyTask(SendPort port) {
    int total = 0;
    for (var i = 0; i < 1000000; i++) {
      total += i;
    }
    port.send(total);
  }

  Future<dynamic> doSomething() async {
    ReceivePort port = ReceivePort();
    var isolate = await Isolate.spawn(makeHeavyTask, port.sendPort);
    return port.first;
  }
}
