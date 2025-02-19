import 'package:flutter/material.dart';
import 'package:water_tracker_appp/to_do_list.dart';
import 'package:water_tracker_appp/water_tracker.dart';

import 'expense_tracker.dart';

void main() {
  runApp(const MyApp());
}





class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   brightness: Brightness.dark
      // ),
      home: ExpenseTracker(),
    );
  }
}


