import 'dart:async';

import 'package:flutter/material.dart';

class Stream2 extends StatefulWidget {
  const Stream2({Key? key}) : super(key: key);

  @override
  _Stream2State createState() => _Stream2State();
}

class _Stream2State extends State<Stream2> {
  // final StreamController _streamController = StreamController();



  // addData()async{
  //   for(int i = 1; i<= 10; i++) {
  //     await Future.delayed(Duration(seconds: 1));
  //
  //     _streamController.sink.add(i);
  //   }
  // }

  Stream<int> numberStream() async*{
    for(int i = 1; i<= 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _streamController.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: const Text("Stream"),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: numberStream().map((number) => "number $number"),
                builder: (context, snapshot){
                  if(snapshot.hasError) {
                    return const Text("hey there is some error");
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text("${snapshot.data}", style: const TextStyle(fontSize: 26),);
                },
              ),

              StreamBuilder(
                stream: numberStream().where((number) => number%2==0),
                builder: (context, snapshot){
                  if(snapshot.hasError) {
                    return const Text("hey there is some error");
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Text("${snapshot.data}", style: const TextStyle(fontSize: 26),);
                },
              ),
            ],
          )
      ),

    );
  }
}
