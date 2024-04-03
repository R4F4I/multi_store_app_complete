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
                child: Center(child: Text('sold out'.toUpperCase(),style: const TextStyle(color: Colors.white,fontSize: 20),)),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)
                      )
                  ),
                child: const Center(
                    child: Text('22',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 40,
                          fontFamily: 'Acme',
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold
                          ),
                )
              ),
              )
        ],)
      ],),
    );
  }
}