import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/layOuts/homeLayOut.dart';

import 'bloc/blocObserver.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
Color primColor = Color(0xFFE2B6AA);
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primColor ,
      ),
      home: HomeLayOut(),
    );
  }
}
