
import 'package:flutter/material.dart';
import 'package:ms_customer_app/main_screens/cart.dart';
import 'package:ms_customer_app/main_screens/home.dart';
import 'package:ms_customer_app/main_screens/category.dart';
import 'package:ms_customer_app/main_screens/profile.dart';
import 'package:ms_customer_app/main_screens/stores.dart';
import 'package:ms_customer_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs =  [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    const ProfileScreen()

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
        items: [

        const BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home',),
        const BottomNavigationBarItem(icon:Icon(Icons.search),label: 'Categores',),
        const BottomNavigationBarItem(icon:Icon(Icons.shop),label: 'Stores',),
        BottomNavigationBarItem(
          icon: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.yellow,
                ),
                badgeContent:Text(context.watch<Cart>().getItems.length.toString()),
                child: const Icon(Icons.shopping_cart_sharp)),
          label: 'Cart',),
        const BottomNavigationBarItem(icon:Icon(Icons.person),label: 'Profile',),
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