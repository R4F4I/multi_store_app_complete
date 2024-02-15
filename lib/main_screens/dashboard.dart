import 'package:flutter/material.dart';
import 'package:multi_store_app/dashboard/edit_profile.dart';
import 'package:multi_store_app/dashboard/manage_products.dart';
import 'package:multi_store_app/dashboard/my_store.dart';
import 'package:multi_store_app/dashboard/supp_balance.dart';
import 'package:multi_store_app/dashboard/supp_orders.dart';
import 'package:multi_store_app/dashboard/supp_statistics.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

List<String> label = [
  'my store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statistics',
];
List<IconData> iconLabel = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart_outlined,

];

List<Widget> pages= const [
  MyStore(),
  SupplierOrders(),
  EditProfile(),
  ManageProducts(),
  BalanceScreen(),
  StatisticsScreen(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'dashboard'),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context,'/welcome_screen' );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
                )
              )
      ],),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>pages[index]));
            },
            child: Card(
              elevation: 30,
              shadowColor: Colors.purpleAccent.shade200,
              color: Colors.blueGrey.withOpacity(1),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Icon(
                    iconLabel[index],
                    size: 90,
                    color: Colors.yellowAccent,
                    ),
                Text(
                    label[index].toUpperCase(),
                    style:const TextStyle(
                      fontSize: 24,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                      fontFamily: 'Acme'),
                      )
                ]),
              ),
          );
          }),
          ),
        ),
      );
    }
  }