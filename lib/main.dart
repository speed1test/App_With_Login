import 'package:all_in_one/activity/fourting.dart';
import 'package:all_in_one/activity/home.dart';
import 'package:flutter/material.dart';
import 'package:all_in_one/activity/loading.dart';
import 'package:all_in_one/activity/second.dart';
import 'package:all_in_one/activity/third.dart';
import 'package:all_in_one/login/login_screen.dart';
import 'package:all_in_one/activity/hello.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/" : (context) => Loading(),
      "/home" : (context) => HomeScreen(),
      "/second" : (context) => SecondScreen(),
      "/third" : (context) => ThirdScreen(),
      "/fourting": (context) => FourtingScreen(),
      "/login": (context) => LoginScreen(),
      "/hello": (context) => HelloScreen()
    },
  ));
}