import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_customers_app/dashboard/edit_profile.dart';
import 'package:ms_customers_app/dashboard/manage_products.dart';
import 'package:ms_customers_app/dashboard/supp_balance.dart';
import 'package:ms_customers_app/dashboard/supp_orders.dart';
import 'package:ms_customers_app/dashboard/supp_statistics.dart';
import 'package:ms_customers_app/main_screens/visit_store.dart';
import 'package:ms_customers_app/widgets/alert_dialog.dart';
import 'package:ms_customers_app/widgets/appbar_widgets.dart';

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

List<Widget> pages= [
  VisitStore(suppID: FirebaseAuth.instance.currentUser!.uid),
  const SupplierOrders(),
  const EditProfile(),
  const ManageProducts(),
  const BalanceScreen(),
  const StatisticsScreen(),
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
              onPressed: () {
                MyAlertDialog.showMyDialog(
                  context: context,
                  title: 'Logging Out',
                  content: 'Are you sure you want to logout?',
                  tapNo: () {
                    Navigator.pop(context);
                  },
                  tapYes: () async {
                    await FirebaseAuth.instance.signOut();                    
                    await Future.delayed(const Duration(microseconds: 100)).whenComplete(()=>Navigator.pop(context));
                    await Future.delayed(const Duration(microseconds: 100)).whenComplete(()=>Navigator.pushReplacementNamed(context, '/welcome_screen'));
                  },
                );
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
                    size: 85,
                    color: Colors.yellowAccent,
                    ),
                Text(
                    label[index].toUpperCase(),
                    style:const TextStyle(
                      fontSize: 20,
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