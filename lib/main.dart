import 'package:flutter/material.dart';
import 'home_page.dart';
import 'expense_page.dart';
import 'income_page.dart';
import 'settings_page.dart';
import 'login_page.dart';

void main() => runApp(ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Start with the login page
    );
  }
}
