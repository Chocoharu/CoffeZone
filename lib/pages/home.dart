import 'package:coffe_zone/pages/init.dart';
import 'package:coffe_zone/pages/coffepage.dart';
import 'package:coffe_zone/pages/shop.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;

      
  static const List<Widget> _widgetOptions = <Widget>[
    Shop(),
    
    CoffePage(),

    Init(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Coffee',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Init',
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}