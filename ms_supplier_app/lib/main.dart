import 'package:flutter/material.dart';

import 'package:ms_supplier_app/auth/customer_login.dart';
import 'package:ms_supplier_app/auth/customer_signup.dart';
import 'package:ms_supplier_app/auth/supplier_login.dart';
import 'package:ms_supplier_app/auth/supplier_signup.dart';
import 'package:ms_supplier_app/main_screens/onboarding_screen.dart';
import 'package:ms_supplier_app/main_screens/supplier_home.dart';


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name:'store_app',
    options: DefaultFirebaseOptions.currentPlatform
    );
  runApp( const MyApp());
}
/*MyApp is a stateless widget created created below and called above(line 4-5)*/
/*this widget returns MaterialApp called CustomerHomeScreen() */
/*CustomerHomeScreen() is called in line 2*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const WelcomeScreen(),
      initialRoute: '/onboarding_screen',
      routes: {
        '/onboarding_screen' :(context) =>const OnboardingScreen(),
        '/supplier_home'  :(context) =>const SupplierHomeScreen(),
        '/customer_signup':(context) =>const CustomerRegister(),
        '/customer_login':(context) =>const CustomerLogin(),
        '/supplier_signup':(context) =>const SupplierRegister(),
        '/supplier_login':(context) =>const SupplierLogin(),
        
      },
    );
      
  }
}