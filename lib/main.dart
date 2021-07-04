import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'package:todo_app/modules/developer_screen/developer_info_screen.dart';

import 'modules/login/login_screen.dart';

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
        LoginScreen.loginScreenRoute: (context) => LoginScreen(),
        HomeLayout.homeScreenRoute: (context) => HomeLayout(),
        DeveloperInfoScreen.developerInfoScreenRoute: (context) =>
            DeveloperInfoScreen(),
      },
      home: SplashScreen(
        seconds: 3,
        loadingText: Text('loading..'),
        loaderColor: Colors.blue,
        backgroundColor: Colors.grey[100],
        title: Text(
          'Todo App',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        navigateAfterSeconds: HomeLayout(),
        image: Image.asset('assets/images/splash_screen.png'),
        photoSize: 120.0,
      ),
    );
  }
}
