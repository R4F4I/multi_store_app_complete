import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class SubCategProducts extends StatelessWidget {
  final String subcategName;
  final String maincategName;
  const SubCategProducts({super.key, required this.subcategName, required this.maincategName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
          

        title: AppBarTitle(title: subcategName)
        
        ),

      body: Center(
        child: Text(maincategName),
        ),
    );
  }
}

