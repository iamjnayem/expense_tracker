import 'package:flutter/material.dart';
import 'package:expense_tracker/database_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/user_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double income = 0.0;
  double expense = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData(context);
  }

  // Future<void> _fetchData() async {
  //   List<Map<String, dynamic>> expenses = await DatabaseHelper().getExpenses();
  //   List<Map<String, dynamic>> incomes = await DatabaseHelper().getIncomes();

  //   double totalExpense = expenses.fold(0, (sum, item) => sum + item['amount']);
  //   double totalIncome = incomes.fold(0, (sum, item) => sum + item['amount']);

  //   setState(() {
  //     expense = totalExpense;
  //     income = totalIncome;
  //   });
  // }

Future<void> _fetchData(BuildContext context) async {
  int userId = Provider.of<UserProvider>(context, listen: false).userId;
  List<Map<String, dynamic>> expenses = await DatabaseHelper().getExpenses(userId);
  List<Map<String, dynamic>> incomes = await DatabaseHelper().getIncomes(userId);

  double totalExpense = expenses.fold(0, (sum, item) => sum + item['amount']);
  double totalIncome = incomes.fold(0, (sum, item) => sum + item['amount']);

  setState(() {
    expense = totalExpense;
    income = totalIncome;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildDataCards(),
              SizedBox(height: 16),
              _buildPieChartCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double cardWidth = (width / 2) - 16; // Adjust card width

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCard('Income', Colors.amber[600]!, cardWidth, income),
            _buildCard('Expense', Colors.amber[400]!, cardWidth, expense),
          ],
        );
      },
    );
  }

  Widget _buildCard(String title, Color color, double width, [double value = 0.0]) {
    return Card(
      color: color,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              value.toStringAsFixed(2), // Format value with 2 decimal places
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartCard() {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildPieChart(),
      ),
    );
  }

  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber[50],
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(16),
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.blueAccent,
                value: income,
                title: 'Income',
                radius: 60,
              ),
              PieChartSectionData(
                color: Colors.tealAccent,
                value: expense,
                title: 'Expense',
                radius: 60,
              ),
            ],
            centerSpaceRadius: 40,
            sectionsSpace: 0,
            startDegreeOffset: -90,
          ),
        ),
      ),
    );
  }
}

