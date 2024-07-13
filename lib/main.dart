import 'package:flutter/material.dart';
import 'package:expense_tracker/login_page.dart';


void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 134, 189, 149), 
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: LoginPage(), 
      ),
    );
  }
}
