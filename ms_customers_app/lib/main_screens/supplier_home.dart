import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_customers_app/main_screens/dashboard.dart';
import 'package:ms_customers_app/main_screens/home.dart';
import 'package:ms_customers_app/main_screens/category.dart';
import 'package:ms_customers_app/main_screens/stores.dart';
import 'package:ms_customers_app/main_screens/upload_product.dart';
import 'package:badges/badges.dart' as badges;

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
    UploadProductScreen(),

  ];
  /*in the widget '_tabs' all values are stored in indexed form hence
  the body in Scaffold calls a value from _tab it uses the _selectedIndex */


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('orders')
        .where('sid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('deliverystatus',isEqualTo: 'preparing') //filter for 'preparing' tab
        .snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {           
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(child: Center(child: CircularProgressIndicator()));
          }
      return Scaffold(

        body:_tabs[_selectedIndex],


        bottomNavigationBar: BottomNavigationBar(
          
          type:BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: const Color.fromARGB(255, 7, 7, 7),
          /*unselectedItemColor: Colors.black,*/
          currentIndex: _selectedIndex,
          items: [

          const BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home',),
          const BottomNavigationBarItem(icon:Icon(Icons.search),label: 'Categories',),
          const BottomNavigationBarItem(icon:Icon(Icons.shop),label: 'Stores',),
          BottomNavigationBarItem(
            icon: badges.Badge(
              showBadge: snapshot.data!.docs.isEmpty ? false : true,
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.yellow,
                ),
              badgeContent: Text(snapshot.data!.docs.length.toString()),
              child: const Icon(Icons.dashboard)),label: 'Dashboard',
              ),
          const BottomNavigationBarItem(icon:Icon(Icons.upload),label: 'Upload',),
        ],
        onTap:(index){   /*by selecting an item the value is passed to index by the onTap function */
          setState(() {
            _selectedIndex = index;
            
          });

        } ,
        ),

      );
    });
  }
}