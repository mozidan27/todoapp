import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mitch/ToDoAoo/data/database.dart';
import 'package:mitch/ToDoAoo/utils/dialog_box.dart';
import 'package:mitch/ToDoAoo/utils/to_do_tile.dart';

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key});

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  //reference the hive box
  final _myBox = Hive.box('myBox');
//text controller
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();
  @override
  void initState() {
    // if this is the 1st time tever to opent he app then create default data
    if (_myBox.get('ToDoList') == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

// checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.tasksName[index][1] = !db.tasksName[index][1];
    });
    db.updateDataBase();
  }

// save new task∏sli
  void saveNewTask() {
    setState(() {
      db.tasksName.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // cancel the task

  void cancelTheTask() {
    setState(
      () {
        Navigator.of(context).pop();
        _controller.clear();
      },
    );
    db.updateDataBase();
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: cancelTheTask,
          onSave: saveNewTask,
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.tasksName.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdcdde1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'ALL TO DO',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: createNewTask,
        backgroundColor: const Color(0xff4d42c0),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.tasksName[index][0],
            taskCompleted: db.tasksName[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
        itemCount: db.tasksName.length,
      ),
    );
  }
}
