import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Player',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
          primaryContainer: Colors.tealAccent,
          secondary: Colors.deepPurple,
          secondaryContainer: Colors.deepPurpleAccent,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Media Player'),
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
      body: Center(
        child : Lottie.asset("assets/splash.json")
      )
    );
  }
}
