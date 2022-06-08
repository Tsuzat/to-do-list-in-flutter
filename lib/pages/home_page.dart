import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/widgets/task_list.dart';

import '../boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    Hive.box('todolist').close();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 235, 251, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(175, 126, 235, 1),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text("Todo List"),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.white),
        child: ValueListenableBuilder<Box<ToDo>>(
          valueListenable: Boxes.getTodolist().listenable(),
          builder: (context, box, _) {
            final todoList = box.values.toList().cast<ToDo>();
            return todoList.isNotEmpty
                ? TaskList(todoList: todoList)
                : const Center(
                    child: Text(
                      "Nothing left to do. Add new tasks",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(151, 153, 167, 1),
                      ),
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a task in list",
        backgroundColor: const Color.fromRGBO(175, 126, 235, 1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Center(child: Text("Add a Task")),
              titleTextStyle: const TextStyle(
                color: Color.fromRGBO(151, 153, 167, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              content: SizedBox(
                height: 150,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(151, 153, 167, 1),
                        ),
                        cursorColor: const Color.fromRGBO(175, 126, 235, 1),
                        cursorHeight: 26,
                        controller: myController,
                        cursorWidth: 2,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(175, 126, 235, 1)),
                          ),
                          hintText: "your task",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(151, 153, 167, 1),
                          ),
                        ),
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Don't be lazy!!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(175, 126, 235, 1),
                          fixedSize: const Size(40, 40),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            setState(() {
                              ToDo temp = ToDo.fromMap(
                                  {'name': myController.text, 'done': false});
                              final box = Boxes.getTodolist();
                              box.add(temp);
                              myController.text = "";
                            });
                          }
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
