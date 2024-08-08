

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/add_address.dart';
import 'package:multi_store_app/providers/auth_repo.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  bool checkOldPasswordValidation = true;


  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // fixes overflow
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Change Password'),
          leading: const AppBarBackButton(),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: Column(children: [
                const Text(
                  'To change your password please fill in the form below and click  \'save changes\' ',
                  style: TextStyle(
                    fontFamily: 'Acme',
                    fontSize: 20,
                    letterSpacing: 1.1,
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                  ),
                      
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty){
                        return 'enter your password';
                      }
                      return null;
                    },
                    controller: oldPasswordController,
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Old Password',
                      hintText: 'Enter your current password',
                      errorText: checkOldPasswordValidation!=true ? 'password not valid' : null
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if (value!.isEmpty) {
                        return 'enter your new password';
                      } return null;
                    },
                    controller: newPasswordController,
                    decoration: textFormDecoration.copyWith(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value){
                      if(value != newPasswordController.text){
                        return 'password not matching';
                      } else if (value!.isEmpty) {
                        return 're-enter your new password';
                      } else {
                         return null;
                      }
                    },
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Repeat Password',
                      hintText: 'Re-enter your new password',
                    ),
                  ),
                ),
                      
                FlutterPwValidator(
                      controller: newPasswordController,
                      minLength: 6,
                      uppercaseCharCount: 2,
                      lowercaseCharCount: 2,
                      numericCharCount: 3,
                      specialCharCount: 1,
                      width: 400,
                      height: 168,
                      onSuccess: (){},
                      onFail: (){}
                  ),
                      
                      
                const Spacer(),
                YellowButton(
                    label: 'save changes', 
                    onPressed: () async{
                      if (formKey.currentState!.validate()){
                        checkOldPasswordValidation = await AuthRepo.checkOldPassword(FirebaseAuth.instance.currentUser!.email, oldPasswordController.text);
                        setState(() {
                          
                        });
                        checkOldPasswordValidation == true
                        ? await AuthRepo.updateUserPassword(newPasswordController.text.trim()).whenComplete((){
                            formKey.currentState!.reset();
                            newPasswordController.clear();
                            oldPasswordController.clear();

                            MyMessageHandler.showSnackBar(_scaffoldKey, 'Your password has been successfully updated!');
                            Future.delayed(const Duration(seconds: 3)).whenComplete(()=>Navigator.pop(context));
                        })
                        : print('old password is invalid');
                        print('form valid');
                      } else {
                        print('form not valid');
                      }
                    }, 
                    width: 0.7,
                  ),
              
              ],),
            ),
          ),
        ),
      ),
    );
  }
}