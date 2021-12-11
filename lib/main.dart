import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_streams_1/BroadcastStream2.dart';
import 'package:flutter_streams_1/SingleStream1.dart';
import 'package:flutter_streams_1/Stream.dart';
import 'package:flutter_streams_1/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                navigatorBtn(const SingleStream1(), "Single Stream 1"),
                navigatorBtn(const BroadcastStream2(), "Broadcast Stream 2"),
                navigatorBtn(const Stream2(), "Stream 2"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget navigatorBtn(page, title) {
    return ElevatedButton(
      child: Text("$title"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => page,
            ));
      },
    );
  }
}
