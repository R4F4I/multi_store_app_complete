import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key,required this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {

  XFile? imageFileLogo;
  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();

  pickStoreLogo() async{
    try{
    final pickedStorelogo= await _picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 300,
    maxWidth: 300,
    imageQuality: 95);
    setState(() {
      imageFileLogo = pickedStorelogo;
    });
  }catch(e){
    setState(() {
      _pickedImageError = e;
    });
    // ignore: avoid_print
    print(_pickedImageError);
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: const AppBarTitle(title: 'edit Store',),
        
      ),
      body: Column(
        children: [
          const Text(
            'Store Logo',
            style: TextStyle(
                fontSize: 24,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.data['storelogo']),
              ),
              imageFileLogo == null
              ?   YellowButton(label: 'Change ?', onPressed: () {
                    pickStoreLogo();
                  }, width: 0.25)
              :   Column(
                    children: [
                      YellowButton(label: 'Change ?', onPressed: () {
                        pickStoreLogo();
                      }, width: 0.25),
                      Icon(Icons.arrow_right_alt_sharp,size: 34,color: Colors.blueGrey.shade200,),
                      YellowButton(label: 'Reset', onPressed: () {
                        setState(() {
                          imageFileLogo = null;
                        });
                      }, width: 0.25),
                ],
              ),
              imageFileLogo==null
              ? const SizedBox()
              : CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.yellow,
                  backgroundImage: FileImage(File(imageFileLogo!.path))
              ),
          ],),
          const Padding(padding: EdgeInsets.all(16),child: Divider(color: Colors.yellow,thickness: 2.5,),)
      ],),

    );
  }
}