import 'package:flutter/material.dart';
import 'package:multi_store_app/auth/customer_login.dart';
import 'package:multi_store_app/auth/customer_signup.dart';
import 'package:multi_store_app/auth/supplier_login.dart';
import 'package:multi_store_app/auth/supplier_signup.dart';
import 'package:multi_store_app/main_screens/customer_home.dart';
import 'package:multi_store_app/main_screens/supplier_home.dart';

import 'package:multi_store_app/main_screens/welcome_screen.dart';                    /*CustomerHomeScreen() is called by being imported*/

import 'package:firebase_core/firebase_core.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //name:'store_app',
    options: DefaultFirebaseOptions.currentPlatform
    );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Cart())
      ],
      child: const MyApp()));
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
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen' :(context) =>const WelcomeScreen(),
        '/customer_home'  :(context) =>const CustomerHomeScreen(),
        '/supplier_home'  :(context) =>const SupplierHomeScreen(),
        '/customer_signup':(context) =>const CustomerRegister(),
        '/customer_login':(context) =>const CustomerLogin(),
        '/supplier_signup':(context) =>const SupplierRegister(),
        '/supplier_login':(context) =>const SupplierLogin(),
        
      },
    );
      
  }
}