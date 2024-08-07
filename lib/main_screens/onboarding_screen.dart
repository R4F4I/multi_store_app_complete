// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/galleries/shoes_gallery.dart';
import 'package:multi_store_app/minor_screens/hot_deals.dart';
import 'package:multi_store_app/minor_screens/subcateg_products.dart';


enum Offers {
  watches,
  shoes,
  sale,
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  Timer? countDownTimer;
  int seconds = 5;
  int? maxDiscount;
  late int selectedIndex;
  late String offerName;
  late String assetName;
  late Offers offer;
  List<int> discounts=[];

  @override
  void initState() {
    selectRandomOffer();
    //startTimer();
    getMaxDiscount();    
    super.initState();
  }

 @override
  void dispose() {
    super.dispose();
  }

  void selectRandomOffer(){

    for (var i = 0; i < Offers.values.length; i++) {
      var random = Random();
      setState(() {
        selectedIndex = random.nextInt(3);
        offerName = Offers.values[selectedIndex].toString();
        assetName = offerName.replaceAll("Offers.", "");
        offer = Offers.values[selectedIndex];
      });
    }
    print(selectedIndex);
    print(offerName);
    print(assetName);
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
      //print('timer.tick: $timer.tick');
      //print(timer.tick);
      //print('seconds: $seconds');
      
    });
  }

  void stopTimer(){
    countDownTimer!.cancel();
  }

  Widget buildAsset (){
    return Image.asset('images/onboard/$assetName.JPEG');
  }

  void navigateToOffer(){
    switch (offer) {      
      case Offers.watches:
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SubCategProducts(
                fromOnBoarding: true,
                subcategName: 'smart watch',
                maincategName: 'electronics'
              )
            ),
          (Route route)=> false
        );
        break;

      case Offers.shoes:
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ShoesGalleryScreen(fromOnBoarding: true,)
            ),
          (Route route)=> false
        );
        break;

      case Offers.sale:
        
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HotDealsScreen(
              fromOnBoarding: true,
              maxDiscount: maxDiscount!.toString(),
              )
            ),
            (Route route)=> false
        );
        break;
    }
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
              navigateToOffer();
            },
            child: buildAsset(),
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
          offer == Offers.sale
          ? Positioned(
              top: 180,
              right: 68,
              child: Text(
                '${maxDiscount.toString()}%',
                style: const TextStyle(
                  fontSize: 100,
                  color: Colors.cyan,
                  fontFamily: 'AkayaTelivigala'
                ),
              ),
            )
          : const SizedBox(),
          Positioned(
            bottom: 70,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'SHOP NOW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}