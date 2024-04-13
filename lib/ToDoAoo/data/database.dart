import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List tasksName = [];
  // referance the box
  final _myBox = Hive.box('myBox');
//run this method if this is the 1st time opening this app
  void createInitialData() {
    tasksName = [
      ['Enter your task by using + button', false],
      // ['Do something else', false]
    ];
  }

  // load the data from data base

  void loadData() {
    tasksName = _myBox.get('ToDoList');
  }

  // update the database
  void updateDataBase() {
    _myBox.put('ToDoList', tasksName);
  }
}
