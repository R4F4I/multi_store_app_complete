// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/galleries/shoes_gallery.dart';
import 'package:multi_store_app/minor_screens/hot_deals.dart';
import 'package:multi_store_app/minor_screens/subcateg_products.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  Timer? countDownTimer;
  int seconds = 3;
  int? maxDiscount;
  List<int> discounts=[];

  @override
  void initState() {
    startTimer();
    getMaxDiscount();
    super.initState();
  }

 @override
  void dispose() {
    super.dispose();
  }

  void startTimer(){
    countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer){
      setState(() {
        seconds --;
      });

      if (seconds < 0) {
        stopTimer();
        Navigator.pushReplacementNamed(context,'/customer_home');
      }
      print('timer.tick: $timer.tick');
      print(timer.tick);
      print('seconds: $seconds');
      
    });
  }

  void stopTimer(){
    countDownTimer!.cancel();
  }

  void getMaxDiscount(){
    FirebaseFirestore.instance
    .collection('products')
    .get()
    .then((QuerySnapshot querySnapshot){
      for (var doc in querySnapshot.docs){
        discounts.add(doc['discount']);
      }
    })
    .whenComplete(()=>setState(() {
      maxDiscount = discounts.reduce(max);
    }));
  }

   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              stopTimer();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HotDealsScreen(
                    fromOnBoarding: true,
                    maxDiscount: maxDiscount!.toString(),
                  )
                  ),

                /* MaterialPageRoute(
                  builder: (context) => const SubCategProducts(
                      fromOnBoarding: true,
                      subcategName: 'smart watch',
                      maincategName: 'electronics'
                    )
                  ) */
                 (Route route)=> false
                );
            },
            child: Image.asset('images/onboard/sale.JPEG'),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Container(
              height: 30,
              width:100,
              decoration: BoxDecoration(
                color: Colors.grey.shade600.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25)),
              child: MaterialButton(
                onPressed:(){
                  stopTimer();
                  Navigator.pushReplacementNamed(context, '/customer_home');
                }, 
                child: seconds <1
                ?  const Text('skip')
                :  Text('skip | $seconds'),
              )
              ),
          ),
        ],
      ),
    );
  }
}