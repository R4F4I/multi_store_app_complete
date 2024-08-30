import 'package:flutter/material.dart';
import 'package:ms_customers_app/widgets/appbar_widgets.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'My Store',),
        leading: const AppBarBackButton(),
      ),
    );
  }
}