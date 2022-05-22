import 'package:flutter/material.dart';
import 'package:whiterabbitmachinetest/pages/employee_listpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomePage(),
      },
    );
  }
}