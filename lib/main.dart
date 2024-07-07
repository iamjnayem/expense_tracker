import 'package:expense_tracker/widgets/mother_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          backgroundColor: Colors.amberAccent,
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.grey[700],
            child: ListView(
              children: const [
                DrawerHeader(
                  child: Center(
                    child: Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 40,
                        //   backgroundColor: Colors.white,
                        // ),

                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Nayem',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text('iamj.nayem@gmail.com'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(leading: Icon(Icons.folder), title: Text('My Files')),
                ListTile(
                    leading: Icon(Icons.group), title: Text('Shared with me')),
                ListTile(leading: Icon(Icons.star), title: Text('Starred')),
                ListTile(leading: Icon(Icons.delete), title: Text('Bin')),
                ListTile(leading: Icon(Icons.upload), title: Text('Upload')),
                Divider(),
                ListTile(leading: Icon(Icons.share), title: Text('Share')),
                ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
                Divider(),
              ],
            ),
          ),
        ),
        body: MotherWidget(),
      ),
    );
  }
}
