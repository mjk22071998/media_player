import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:media_player/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {"/main": (context) => MainActivity()},
      title: 'Media Player',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, "/main");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Lottie.asset(
      "assets/splash.json",
      controller: _controller,
      onLoaded: (p0) {
        _controller.duration = p0.duration;
        print("object");
        _controller.forward();
      },
    )));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
