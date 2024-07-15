import 'package:flutter/material.dart';
import 'package:expense_tracker/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/user_provider.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCategory;
  final TextEditingController _dateController = TextEditingController();

  Future<List<String>> _fetchIncomeCategories(BuildContext context) async {
    int userId = Provider.of<UserProvider>(context, listen: false).userId;
    var categories = await DatabaseHelper().getIncomeCategories(userId);
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: FutureBuilder<List<String>>(
          future: _fetchIncomeCategories(context), // Pass context here
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List<String> categories = snapshot.data ?? [];
            if (_selectedCategory == null && categories.isNotEmpty) {
              _selectedCategory = categories[0];
            }

            return Column(
              children: [
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Income Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());

                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );

                    if (date != null) {
                      _dateController.text = "${date.toLocal()}".split(' ')[0];
                    }
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> row = {
                        'amount': double.parse(_amountController.text),
                        'category': _selectedCategory,
                        'date': _dateController.text,
                        'user_id': Provider.of<UserProvider>(context, listen: false).userId, // include user_id
                      };
                      await DatabaseHelper().insertIncome(row);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Income Added')),
                      );
                    }
                  },
                  child: Text('Add Income'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

