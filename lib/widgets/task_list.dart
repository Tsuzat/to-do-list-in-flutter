import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskList extends StatefulWidget {
  final List<Map<String, dynamic>> todoList;
  const TaskList({
    Key? key,
    required this.todoList,
  }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  void _deleteItem(int index) {
    widget.todoList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) => ListTile(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget.todoList[index]['done'] = !widget.todoList[index]['done'];
            });
          },
          icon: widget.todoList[index]['done']
              ? const Icon(Icons.circle)
              : const Icon(Icons.circle_outlined),
          color: widget.todoList[index]['done']
              ? const Color.fromRGBO(175, 126, 235, 1)
              : const Color.fromRGBO(151, 153, 167, 1),
          iconSize: 26,
        ),
        title: Text(
          widget.todoList[index]['name'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(151, 153, 167, 1),
            decorationStyle: TextDecorationStyle.solid,
            decorationThickness: 3,
            decorationColor: const Color.fromRGBO(151, 153, 167, 1),
            decoration: widget.todoList[index]['done']
                ? TextDecoration.lineThrough
                : null,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: widget.todoList[index]['done']
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _deleteItem(index);
                  });
                },
                icon: const Icon(
                  CupertinoIcons.delete_simple,
                  size: 22,
                ),
              )
            : null,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(child: Text("Task")),
              titleTextStyle: const TextStyle(
                  color: Color.fromRGBO(151, 153, 167, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              contentTextStyle: const TextStyle(
                color: Color.fromRGBO(151, 153, 167, 1),
                fontSize: 16,
              ),
              content: Text(widget.todoList[index]['name']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.todoList[index]['done'] =
                          !widget.todoList[index]['done'];
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    widget.todoList[index]['done']
                        ? "Mark as to do"
                        : "Mark as done",
                    style: const TextStyle(
                      color: Color.fromRGBO(175, 126, 235, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.todoList.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Color.fromRGBO(175, 126, 235, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
