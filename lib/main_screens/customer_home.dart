// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/home.dart';
import 'package:multi_store_app/main_screens/category.dart';
import 'package:multi_store_app/main_screens/profile.dart';
import 'package:multi_store_app/main_screens/stores.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    CartScreen(),
    ProfileScreen()

  ];
  /*in the widget '_tabs' all values are stored in indexed form hence
  the body in Scaffold calles a value from _tab it uses the _selectedIndex */


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:_tabs[_selectedIndex],


      bottomNavigationBar: BottomNavigationBar(
        
        type:BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: const Color.fromARGB(255, 7, 7, 7),
        /*unselectedItemColor: Colors.black,*/
        currentIndex: _selectedIndex,
        items: const [

        BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home',),
        BottomNavigationBarItem(icon:Icon(Icons.search),label: 'Categores',),
        BottomNavigationBarItem(icon:Icon(Icons.shop),label: 'Stores',),
        BottomNavigationBarItem(icon:Icon(Icons.shopping_cart),label: 'Cart',),
        BottomNavigationBarItem(icon:Icon(Icons.person),label: 'Profile',),
      ],
      onTap:(index){   /*by selecting an item the value is passed to index by the onTap function */
        setState(() {
          _selectedIndex = index;
          
        });

      } ,
      ),

    );
  }
}