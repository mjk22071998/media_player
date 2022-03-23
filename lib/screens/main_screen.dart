import 'package:flutter/material.dart';

class MainActivity extends StatelessWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Media Player"),),
      body: const Center(child: Text("Controller worked"),)
    );

  }
}