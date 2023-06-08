import 'dart:async';

import 'package:flutter/material.dart';
class DemoIsolateWidget extends StatefulWidget {
  const DemoIsolateWidget({Key? key}) : super(key: key);

  @override
  State<DemoIsolateWidget> createState() => _DemoIsolateWidgetState();
}

class _DemoIsolateWidgetState extends State<DemoIsolateWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    doSomething().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Isolate"),
      ),
      body: Container(
        child: Column(
          children: [
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  Future<int> doSomething() {
    Completer<int> completer = Completer();
    int total = 0;
    for(var i = 0; i < 10000000000; i++) {
      total += i;
    }
    completer.complete(total);
    return completer.future;
  }
}
