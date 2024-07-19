

import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/add_address.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();





  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
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
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
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
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Old Password',
                      hintText: 'Enter your current password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: textFormDecoration.copyWith(
                      labelText: 'New Password',
                      hintText: 'Enter your new password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: textFormDecoration.copyWith(
                      labelText: 'Repeat Password',
                      hintText: 'Re-enter your new password',
                    ),
                  ),
                ),
                const Spacer(),
                YellowButton(label: 'save changes', onPressed: () {}, width: 0.7),
              
              ],),
            ),
          ),
        ),
      ),
    );
  }
}