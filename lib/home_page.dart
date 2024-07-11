

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class HomePage extends StatefulWidget {
//   final double income; // Add income and expense variables
//   final double expense;

//   const HomePage({required this.income, required this.expense});

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   double width = constraints.maxWidth;
//                   double cardWidth = (width / 2) - 16; // Adjust card width

//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildCard('Income', Colors.amber[600]!, cardWidth, widget.income), // Use widget properties
//                       _buildCard('Expense', Colors.amber[400]!, cardWidth, widget.expense),
//                     ],
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
//               LayoutBuilder(
//                 builder: (context, constraints) {
//                   double width = constraints.maxWidth;
//                   double cardWidth = (width / 3) - 16; // Adjust card width

//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildCard('Monthly', Colors.amber[600]!, cardWidth),
//                       _buildCard('Weekly', Colors.amber[400]!, cardWidth),
//                       _buildCard('Daily', Colors.amber[300]!, cardWidth),
//                     ],
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
//               _buildPieChart(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCard(String title, Color color, double width, [double value = 0.0]) {
//     return Card(
//       color: color,
//       child: Container(
//         width: width,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 18, color: Colors.black),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               value.toStringAsFixed(2), // Format value with 2 decimal places
//               style: TextStyle(fontSize: 24, color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPieChart() {
//   return AspectRatio(
//     aspectRatio: 1.5,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.amber[50], // Light amber background color
//         shape: BoxShape.circle,
//       ),
//       padding: EdgeInsets.all(16),
//       child: PieChart(
//         PieChartData(
//           sections: [
//             PieChartSectionData(
//               color: Colors.blueAccent, // Custom professional color
//               value: widget.income, // Use widget properties
//               title: 'Income',
//               radius: 60,
//             ),
//             PieChartSectionData(
//               color: Colors.tealAccent, // Custom professional color
//               value: widget.expense, // Use widget properties
//               title: 'Expense',
//               radius: 60,
//             ),
//           ],
//           centerSpaceRadius: 40,
//           sectionsSpace: 0,
//           startDegreeOffset: -90,
//         ),
//       ),
//     ),
//   );
// }

// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  final double income; // Add income and expense variables
  final double expense;

  const HomePage({required this.income, required this.expense});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            _buildCard('Income', Colors.amber[600]!, cardWidth, widget.income),
            _buildCard('Expense', Colors.amber[400]!, cardWidth, widget.expense),
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
      // Define your standard color for the card here
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
          color: Colors.amber[50], // Light amber background color for the pie chart container
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(16),
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.blueAccent, // Custom professional color for income
                value: widget.income, // Use widget properties
                title: 'Income',
                radius: 60,
              ),
              PieChartSectionData(
                color: Colors.tealAccent, // Custom professional color for expense
                value: widget.expense, // Use widget properties
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

