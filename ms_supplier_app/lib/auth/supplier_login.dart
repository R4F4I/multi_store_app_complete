// ignore_for_file: avoid_print,

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier_app/widgets/auth_widgets.dart';
import 'package:ms_supplier_app/widgets/snackbar.dart';
import 'package:ms_supplier_app/widgets/yellow_button.dart';


class SupplierLogin extends StatefulWidget {
  const SupplierLogin({super.key});

  @override
  State<SupplierLogin> createState() => _SupplierLoginState();
}

class _SupplierLoginState extends State<SupplierLogin> {
  
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;
  bool processing = false;
  bool sendEmailVerification = false;


void logIn() async {
  setState(() {
    processing=true;
  });
    if (_formKey.currentState!.validate()) {
      
        try{
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
        _formKey.currentState!.reset();
        await FirebaseAuth.instance.currentUser!.reload();  
        
            if (FirebaseAuth.instance.currentUser!.emailVerified){
              _formKey.currentState!.reset();
              await Future.delayed(const Duration(microseconds: 100)).whenComplete(()=>Navigator.pushReplacementNamed(context, '/supplier_home'));
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

          setState(() {processing = false;});
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
                      onPressed: (){}, 
                      child: const Text(
                        "Forgot Password? ",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic),)),
                     HaveAccount(
                      haveAccount: 'Haven\'t created an Account? ',
                      actionLabel: 'Sign Up',
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/supplier_signup');
                      },
                    ),
                  
                     processing == true
                     ? const Center(child: CircularProgressIndicator())
                     : AuthMainButton(
                       mainButtonLabel: 'Log In',
                        onPressed: (){logIn();},
                    ),
                    const LoginDivider(),
                    //const GoogleSignInButton()
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

