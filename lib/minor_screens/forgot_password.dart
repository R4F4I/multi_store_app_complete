import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/auth_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Forgot Password ?',),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text(
                'To reset your password, \n\n Please enter your Email \n and click the button below',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'acme',
                  ),
                ),
              const SizedBox(height: 80,),
              TextFormField(
                validator: (value){
                  if (value!.isEmpty){
                    return 'please enter your email' ;
                  } else if (!value.isValidEmail()){
                      return 'invalid email';
                  } else if (value.isValidEmail()){
                      return null;
                  } 
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: textFormDecoration.copyWith(
                  labelText: 'Email Address',
                  hintText: 'enter your email',
                ),

              ),
              const SizedBox(height: 80,),
              YellowButton(
                    label: 'send reset password link',
                    onPressed: () {},
                    width: 0.5,
                )
            ],),
          ),
        ),
      ),
    );
  }
}

