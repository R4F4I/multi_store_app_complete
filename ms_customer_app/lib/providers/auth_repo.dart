

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

    try {
      await auth.signInWithEmailAndPassword(email: email,password: password);  
    } catch (e) {
      print(e);
    } 
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

    final User? user;
    try {
      user  = FirebaseAuth.instance.currentUser!;
        try {
          bool userIsVerified = user.emailVerified;

          return userIsVerified == true;
        } catch (e) {
          print(e);

          return false;
        }
     } catch (e) {
      print(e);
    }
      return true;    
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
  // check if the password matches the email 
  static Future <bool> checkOldPassword(email,password) async{
      
      AuthCredential authCredential =  EmailAuthProvider.credential(email: email,password: password);
      try {
        var credentialResult = await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(authCredential);
        return credentialResult.user != null;
      } catch (e) {
          print(e);
          return false;  
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
  static Future <void> updateDisplayName(storeName) async{

    User user = FirebaseAuth.instance.currentUser!;
    await user.updateDisplayName(storeName);
  }

  //-------------------------------------------------------------------------------


  // update supplier logo
  static Future <void> updateProfileImage(storeLogo) async{

    User user = FirebaseAuth.instance.currentUser!;
    await user.updatePhotoURL(storeLogo);
  }
  
  //-------------------------------------------------------------------------------


  // update supplier logo
  static Future <void> updateUserPassword(password) async{

    User user = FirebaseAuth.instance.currentUser!;
    try {
      await user.updatePassword(password);
    } catch (e) {
      print(e);
    }
    
    
  }

  
  
}