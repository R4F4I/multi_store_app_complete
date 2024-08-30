import 'package:flutter/material.dart';
import 'package:ms_customers_app/widgets/appbar_widgets.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Edit Profile',),
        leading: const AppBarBackButton(),
      ),
    );
  }
}