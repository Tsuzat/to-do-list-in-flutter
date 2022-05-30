import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      ),
      title: 'To Do List',
      home: const HomePage(),
    );
  }
}
