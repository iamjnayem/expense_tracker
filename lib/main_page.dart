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

  static List<Widget> _widgetOptions(double totalExpense, double totalIncome) {
    return [
      HomePage(),
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
      body:
          _widgetOptions(_totalExpense, _totalIncome).elementAt(_selectedIndex),
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
