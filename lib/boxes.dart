import 'package:hive/hive.dart';
import 'package:to_do_list/models/todo.dart';

class Boxes {
  static Box<ToDo> getTodolist() =>
      Hive.box<ToDo>('todolist');
}