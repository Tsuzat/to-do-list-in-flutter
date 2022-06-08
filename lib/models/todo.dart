import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject{
  @HiveField(0)
  String name;

  @HiveField(1)
  bool done;

  ToDo({required this.name, required this.done});

  factory ToDo.fromMap(Map<String, dynamic> mp) {
    return ToDo(
      name: mp['name'],
      done: mp['done'],
    );
  }
  Map<String, dynamic> toMap() => {'name': name, 'done': done};
}

const List<Map<String, dynamic>> defaultTasks = [
  {
    "name": "Get up at 6 PM",
    "done": true,
  },
  {
    "name": "Take Breakfast",
    "done": false,
  },
  {
    "name": "Do exercise",
    "done": true,
  },
  {
    "name": "Bath",
    "done": false,
  },
  {
    "name": "Morning Jogg",
    "done": true,
  },
];

class ToDoList {
  static List<ToDo> todolist =
      List.from(defaultTasks).map<ToDo>((mp) => ToDo.fromMap(mp)).toList();
}
