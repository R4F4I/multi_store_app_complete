

import 'package:flutter/material.dart';
import 'package:ms_supplier_app/dashboard/delivered_orders.dart';
import 'package:ms_supplier_app/dashboard/preparing_orders.dart';
import 'package:ms_supplier_app/dashboard/shipping_orders.dart';
import 'package:ms_supplier_app/widgets/appbar_widgets.dart';

class SupplierOrders extends StatelessWidget {
  const SupplierOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(title: 'Orders',),
          leading: const AppBarBackButton(),
          bottom: const TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
            tabs: [
            RepeatedTab(label: 'Preparing'),
            RepeatedTab(label: 'Shipping'),
            RepeatedTab(label: 'Delivered'),
          ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Shipping(),
          Delivered(),
        ],),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(child: Text(label,style: const TextStyle(color: Colors.grey),),),
    );
  }
}