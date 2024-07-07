import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/card.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ThemedCard(
                color: Colors.white,
                icon: Icons.remove_circle,
                text: 'Expense',
                textColor: Colors.amber,
                onTap: () {
                  // Action for the first card
                },
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ThemedCard(
                color: Colors.amber,
                icon: Icons.add_circle,
                text: 'Income',
                textColor: Colors.white,
                onTap: () {
                  // Action for the second card
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
