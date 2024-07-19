

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{

  //Email-pwd SIGN UP
  static Future <void> signUpWithEmailAndPassword(email, password) async{

    final auth = FirebaseAuth.instance;

    await auth.createUserWithEmailAndPassword(email: email,password: password);
  }

  //-------------------------------------------------------------------------------

  //Email-pwd LOGIN
  static Future <void> logInWithEmailAndPassword(email, password) async{

    final auth = FirebaseAuth.instance;

    await auth.signInWithEmailAndPassword(email: email,password: password);
  }

  //-------------------------------------------------------------------------------

  //reload user data
  static Future <void> reloadUserData() async{

    final User user = FirebaseAuth.instance.currentUser!;

    await user.reload();
  }

  //-------------------------------------------------------------------------------


  //verify user email boolean
  //  - we cannot remove async because `userIsVerified` is dependant on it
  static Future <bool> emailVerified() async{

    final User user = FirebaseAuth.instance.currentUser!;

    try {
      bool userIsVerified = user.emailVerified;

      return userIsVerified == true;
    } catch (e) {
      print(e);

      return false;
    }
  }

  //-------------------------------------------------------------------------------


  //Email-verification
  static Future <void> sendEmailVerification() async{
      User user = FirebaseAuth.instance.currentUser!;
    try{
          await user.sendEmailVerification();
   }catch(e){print(e);}
  }

  //-------------------------------------------------------------------------------
  // password reset via email 
  static Future <void> sendPasswordResetEmail(email) async{
      
    try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
        print(e);
    }
  }

  //-------------------------------------------------------------------------------


  // uid getter
  static get uid{
    User user = FirebaseAuth.instance.currentUser!;
    return user.uid;
  }

  //-------------------------------------------------------------------------------


  // update supplier name
  static Future <void> updateSupplierName(storeName) async{

    User user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(storeName);
  }

  //-------------------------------------------------------------------------------


  // update supplier logo
  static Future <void> updateStoreLogo(storeLogo) async{

    User user = FirebaseAuth.instance.currentUser!;
    await user.updatePhotoURL(storeLogo);
  }

  
  
}