import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        HomeLayout.homeScreenRoute: (context) => HomeLayout(),
      },
      home: HomeLayout(),
    );
  }
}
