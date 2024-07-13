// import 'package:flutter/material.dart';
// import 'package:expense_tracker/home_page.dart';
// import 'package:expense_tracker/expense_page.dart';
// import 'package:expense_tracker/income_page.dart';
// import 'package:expense_tracker/settings_page.dart';
// import 'package:expense_tracker/login_page.dart';

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;
//   static final List<Widget> _widgetOptions = <Widget>[
//     const HomePage(
//       expense: 10,
//       income: 20,
//     ),
//     IncomePage(),
//     ExpensePage(),
//     SettingsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Expense Tracker'),
//         backgroundColor: Colors.amberAccent,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: const Text("Profile"),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           try {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginPage()),
//                             );
//                           } catch (error) {
//                             // Handle navigation error
//                             print(error);
//                           }
//                         },
//                         child: Text("Logout"),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//           )
//         ],
//       ),
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.red,
//         unselectedItemColor: Colors.blue,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Income',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.remove),
//             label: 'Expense',
//           ),
         
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:expense_tracker/home_page.dart';
import 'package:expense_tracker/expense_page.dart';
import 'package:expense_tracker/income_page.dart';
import 'package:expense_tracker/settings_page.dart';
import 'package:expense_tracker/login_page.dart';
import 'package:expense_tracker/database_helper.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  double _totalExpense = 0.0;
  double _totalIncome = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchTotalExpenseAndIncome();
  }

  Future<void> _fetchTotalExpenseAndIncome() async {
    final dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> expenses = await dbHelper.getExpenses();
    List<Map<String, dynamic>> incomes = await dbHelper.getIncomes();

    double totalExpense = expenses.fold(0, (sum, item) => sum + item['amount']);
    double totalIncome = incomes.fold(0, (sum, item) => sum + item['amount']);

    setState(() {
      _totalExpense = totalExpense;
      _totalIncome = totalIncome;
    });
  }

  static List<Widget> _widgetOptions(double totalExpense, double totalIncome) {
    return [
      HomePage(expense: totalExpense, income: totalIncome),
      IncomePage(),
      ExpensePage(),
      SettingsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Profile"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          try {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          } catch (error) {
                            // Handle navigation error
                            print(error);
                          }
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: _widgetOptions(_totalExpense, _totalIncome).elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Income',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove),
            label: 'Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
