import 'package:flutter/material.dart';
import 'package:expense_tracker/login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/providers/user_provider.dart';

void main() => runApp(const ExpenseTrackerApp());

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Expense Tracker',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Expense Tracker'),
            backgroundColor: Colors.amberAccent,
          ),
          body: LoginPage(),
        ),
      ),
    );
    
  }
}
