// ignore_for_file: avoid_print,

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier_app/minor_screens/forgot_password.dart';
import 'package:ms_supplier_app/widgets/auth_widgets.dart';
import 'package:ms_supplier_app/widgets/snackbar.dart';
import 'package:ms_supplier_app/widgets/yellow_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {

  CollectionReference customers = FirebaseFirestore.instance.collection('customers');

  Future <bool> checkIfDocExists(String docId) async{
    try {
      var doc = await customers.doc(docId).get();
      return doc.exists;

    } catch (e) {
      return false;
    }
  }

  bool docExists = false;


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    print(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential)
      .whenComplete(() async{
        User user =  FirebaseAuth.instance.currentUser!;


        print(googleUser!.id);
        print(googleUser);
        print(user);
        
        docExists = await checkIfDocExists(user.uid);

        docExists ==false
        ?  await customers.doc(user.uid).set({
            'name':user.displayName,
            'email':user.email,
            'profileimage':user.photoURL,
            'phone':'',
            'address':'',
            'cid':user.uid, // customer_i.d
          }).then((value)=>navigate())
        : navigate();
      });
  }
  
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;
  bool processing = false;
  bool sendEmailVerification = false;

  void navigate(){
    Navigator.pushReplacementNamed(context,'/customer_home');
  }

  void logIn() async {
  
    setState(() {
      processing=true;
      
    });
      if (_formKey.currentState!.validate()) {
        
          try{
              await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);                
              _formKey.currentState!.reset();
              await FirebaseAuth.instance.currentUser!.reload();  
              
              if ( FirebaseAuth.instance.currentUser!.emailVerified){
                  _formKey.currentState!.reset();
                  await Future.delayed(const Duration(microseconds: 100)).whenComplete(()=>Navigator.pushReplacementNamed(context, '/customer_home')); 
              } 
              else {
                setState(() {
                  processing=false;
                  sendEmailVerification = true;
                });
                MyMessageHandler.showSnackBar(_scaffoldKey, 'Please check your inbox ');
                
              }
          } 
          on FirebaseAuthException catch(e){
            setState(() {processing=false;});
            print('customer login exception caught');
            MyMessageHandler.showSnackBar(_scaffoldKey,e.message.toString());
          }

      } 
      else {
        setState(() {processing=false;});
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields ');}
    
  }



  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const AuthHeaderLabel(headerLabel: 'Log In',),
                    
                     SizedBox(
                      height: 50,
                      child: sendEmailVerification == true
                        ? Center(
                          child: YellowButton(
                            label: 'resend Email Verification', 
                            onPressed: () async{
                              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              Future.delayed(const Duration(seconds: 10)).whenComplete((){
                                setState(() {
                                sendEmailVerification = false;
                              });
                            });
                          }, 
                          width: 0.6),
                        )
                        : const SizedBox(),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value){
                          if (value!.isEmpty){
                            return 'You havent entered your Email Address';
                          }
                          else if (value.isValidEmail()==false){
                            return 'invalid Email Address';
                          }
                          else if (value.isValidEmail()==true){
                            return null;  
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          email=value;
                        },
      
                      
      
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Email Address',
                          hintText: 'Enter your Email Address please',)
                        
                  
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value){
                          if (value!.isEmpty){
                            return 'You havent entered your Password';
                          }
                          return null;
                        },
                        obscureText: !passwordVisible,
                        onChanged: (value){
                          password=value;
                          //print(password);
                        },
      
                      
      
                        decoration: textFormDecoration.copyWith(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              passwordVisible= !passwordVisible;
                            });
                          }, icon: Icon(
                            passwordVisible
                            ?Icons.visibility_off
                            :Icons.visibility, 
                            
                            color: Colors.purple,)),
                          labelText: 'Password',
                          hintText: 'Enter your Password please',)
                        
                        
                          ),
                    ),
                    TextButton(
                      onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> const ForgotPassword()));}, 
                      child: const Text(
                        "Forgot Password? ",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic),)),
                     HaveAccount(
                      haveAccount: 'Haven\'t created an Account? ',
                      actionLabel: 'Sign Up',
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/customer_signup');
                      },
                    ),
                  
                     processing == true
                     ? const Center(child: CircularProgressIndicator())
                     : AuthMainButton(
                       mainButtonLabel: 'Log In',
                        onPressed: (){logIn();},
                     ),
                     const LoginDivider(),
                     GoogleSignInButton(
                        onPressed: () async{
                          try {
                            await signInWithGoogle();
                          } catch (e) {
                            MyMessageHandler.showSnackBar(_scaffoldKey, e.toString());
                            print(e);
                          }
                        },
                      )
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }  
}

