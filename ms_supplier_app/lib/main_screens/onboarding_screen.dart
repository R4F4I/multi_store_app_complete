// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>{

  Timer? countDownTimer;
  int seconds = 5;
  List<int> discounts=[];



  @override
  void initState() {
    startTimer();
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
        Navigator.pushReplacementNamed(context,'/supplier_login');
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
    return Image.asset('images/onboard/supplieronboard.jpg');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildAsset(),
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
                  Navigator.pushReplacementNamed(context, '/supplier_login');
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