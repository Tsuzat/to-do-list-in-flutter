import 'package:flutter/material.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/todo.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
  await Hive.openBox<ToDo>('todolist');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      title: 'To Do List',
      home: const HomePage(),
    );
  }
}
