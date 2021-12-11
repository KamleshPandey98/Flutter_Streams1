import 'dart:async';

import 'package:flutter/material.dart';

class BroadcastStream2 extends StatefulWidget {
  const BroadcastStream2({Key? key}) : super(key: key);

  @override
  _BroadcastStream2State createState() => _BroadcastStream2State();
}

class _BroadcastStream2State extends State<BroadcastStream2> {
  int _counter = 0;
  static const String start = "Start";
  static const String stop = "Stop";
  // late String actionText;
  Timer? _timer;
  final StreamController<int> _streamController = StreamController<int>();
  late Stream myBroadcastStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // actionText = start;
    myBroadcastStream = _streamController.stream.asBroadcastStream();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    // myBroadcastStream;
  }

  void _incrementCounter() {
    _streamController.sink.add(_counter++);
  }

  void _continuousChangingCounter() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        _incrementCounter();
      }
    });
  }

  void _stopListeningToChange() {
      _counter = 0;
      _streamController.sink.add(_counter);
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  _toggle() {
    if(_timer==null){
      return _continuousChangingCounter();
    }
    !_timer!.isActive
        ? _continuousChangingCounter()
        : _stopListeningToChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Broadcast Stream 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              initialData: _counter,
              stream: myBroadcastStream,
              builder: (context, data) {
                return Text(
                  "${data.data}",
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "togglerBroadcast",
        onPressed: _toggle,
        tooltip: 'toggle stream',
        child: StreamBuilder(
            initialData: _counter,
            stream: myBroadcastStream,
            builder: (context, snap) {
              return Text(snap.data == 0 ? start : stop);
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
