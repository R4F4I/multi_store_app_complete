import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Statistics',),
        leading: const AppBarBackButton(),
      ),
      body: Column(children: [
        Column(children: [
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width*0.55,
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                      )
                  ),
                child: Center(child: Text('sold out'.toUpperCase())),
              )
        ],)
      ],),
    );
  }
}