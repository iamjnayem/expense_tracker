
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/database_helper.dart';
import 'package:expense_tracker/providers/user_provider.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController _expenseCategoryController = TextEditingController();
  final TextEditingController _incomeCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _expenseCategoryController,
            decoration: InputDecoration(labelText: 'New Expense Category'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_expenseCategoryController.text.isNotEmpty) {
                Map<String, dynamic> row = {
                  'name': _expenseCategoryController.text,
                  'type': 'expense',
                  'user_id': userId,
                };
                await DatabaseHelper().insertCategory(row);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Expense Category Added')),
                );
                _expenseCategoryController.clear();
              }
            },
            child: Text('Add Expense Category'),
          ),
          TextField(
            controller: _incomeCategoryController,
            decoration: InputDecoration(labelText: 'New Income Category'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_incomeCategoryController.text.isNotEmpty) {
                Map<String, dynamic> row = {
                  'name': _incomeCategoryController.text,
                  'type': 'income',
                  'user_id': userId,
                };
                await DatabaseHelper().insertCategory(row);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Income Category Added')),
                );
                _incomeCategoryController.clear();
              }
            },
            child: Text('Add Income Category'),
          ),
        ],
      ),
    );
  }
}
