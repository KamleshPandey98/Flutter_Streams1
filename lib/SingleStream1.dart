import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_streams_1/constants.dart';

class SingleStream1 extends StatefulWidget {
  const SingleStream1({Key? key}) : super(key: key);

  @override
  _SingleStream1State createState() => _SingleStream1State();
}

class _SingleStream1State extends State<SingleStream1> {
  int _counter = 0;
  static const String start = "Start";
  static const String stop = "Stop";
  late String actionText;
  Timer? _timer;
  StreamController<int> _streamController = StreamController<int>();
  final StreamController _streamController2 = StreamController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actionText = start;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
    _streamController2.close();
  }

  void _incrementCounter() {
    _streamController.sink.add(_counter++);
  }

  void _continuousChangingCounter() {
    if (_timer != null && _timer!.isActive) {
      return;
    }
    if (_streamController.isClosed) {
      setState(() {
        _streamController = StreamController();
      });
    }
    actionText = stop;
    _streamController2.sink.add(actionText);
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        _incrementCounter();
      }
    });
  }

  void _stopListeningToChange() {
    _counter = 0;
    if (!_streamController.isClosed) {
      _streamController.sink.add(_counter);
      actionText = start;
      _streamController2.sink.add(actionText);
      _streamController.close();
    }
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  void _toggle() {
    actionText == start
        ? _continuousChangingCounter()
        : _stopListeningToChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Single Stream 1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              initialData: _counter,
              stream: _streamController.stream,
              builder: (context, data) {
                return Text("${data.data}", style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),);
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "toggler",
        onPressed: _toggle,
        tooltip: 'toggle stream',
        child: StreamBuilder(
            initialData: actionText,
            stream: _streamController2.stream,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
