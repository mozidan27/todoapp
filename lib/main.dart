import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mitch/ToDoAoo/toDo_home_page.dart';

void main() async {
  // init the hive

  await Hive.initFlutter();

  //  open a box

  var box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
