import 'package:flutter/material.dart';
import 'package:russian_gold/model/data.dart';
import 'package:russian_gold/screens/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Russian Gold',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
