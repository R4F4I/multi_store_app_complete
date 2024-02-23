// ignore: file_names
import 'package:flutter/material.dart';
import 'package:multi_store_app/main_screens/dashboard.dart';
//import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/home.dart';
import 'package:multi_store_app/main_screens/category.dart';
//import 'package:multi_store_app/main_screens/profile.dart';
import 'package:multi_store_app/main_screens/stores.dart';
import 'package:multi_store_app/main_screens/upload_product.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashboardScreen(),
    UploadProduct(),

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
        BottomNavigationBarItem(icon:Icon(Icons.dashboard),label: 'Dashboard',),
        BottomNavigationBarItem(icon:Icon(Icons.upload),label: 'Upload',),
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