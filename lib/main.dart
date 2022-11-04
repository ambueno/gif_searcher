import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif_searcher/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GIF Searcher',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        backgroundColor: Colors.black,
      ),
      home: HomePage(title: 'GIF Searcher'),
    );
  }
}
