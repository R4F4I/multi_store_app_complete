import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ms_customer_app/widgets/appbar_widgets.dart';
import 'package:ms_customer_app/widgets/snackbar.dart';
import 'package:ms_customer_app/widgets/yellow_button.dart';

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key,required this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {

  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
  final ImagePicker _picker = ImagePicker();
  late String storeName;
  late String phoneNumber;
  late String storeLogo;
  late String storeCover;
  var processing = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

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

  pickCoverImage() async{
    try{
    final pickedStoreCover= await _picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 300,
    maxWidth: 300,
    imageQuality: 95);
    setState(() {
      imageFileCover = pickedStoreCover;
    });
  }catch(e){
    setState(() {
      _pickedImageError = e;
    });
    // ignore: avoid_print
    print(_pickedImageError);
  }
  }

  uploadStoreLogo() async{
    if(imageFileLogo != null){
      try{
        firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage
        .instance.ref('supp-images/${widget.data['email']}.jpg');
        
        await ref.putFile(File(
          imageFileLogo!.path
          ));
        storeLogo = await ref.getDownloadURL();
      }
      catch(e){
        // ignore: avoid_print
        print(e);
      }
    }
    else{
      storeLogo = widget.data['storelogo'];
    }
  }

  Future uploadStoreCover() async{
    if(imageFileCover != null){
      try{
        firebase_storage.Reference ref2 = firebase_storage
        .FirebaseStorage
        .instance.ref('supp-images/${widget.data['email']}-cover.jpg');
        
        await ref2.putFile(File(
          imageFileCover!.path
          ));
        storeCover = await ref2.getDownloadURL();
      }
      catch(e){
        // ignore: avoid_print
        print(e);
      }
    }
    else{
      storeCover = widget.data['coverimage'];
    }
  }

  editStoreData() async{
    await FirebaseFirestore.instance.runTransaction((transaction) async{
      DocumentReference documentReference = FirebaseFirestore.instance.collection('suppliers').doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'storename': storeName,
        'phone':phoneNumber,
        'storelogo': storeLogo,
        'coverimage': storeCover,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async{
    if (formKey.currentState!.validate()){
      //continue
      formKey.currentState!.save();
      setState(() {
        processing = true;
      });
      await uploadStoreLogo().whenComplete(() async=> await uploadStoreCover().whenComplete(()=>editStoreData()));
    }
    else{
      MyMessageHandler.showSnackBar(scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(title: 'edit Store',),
          
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          reverse: true,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Column(
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
                          radius: 65,
                          backgroundColor: Colors.teal,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(widget.data['storelogo']),
                          ),
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
                Column(
                  children: [
                    const Text(
                      'Cover Image',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        widget.data['coverimage'] == ''
                         ? const CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.teal,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage('images/inapp/coverimage.jpg')),
                         ) 
                         : CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.teal,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(widget.data['coverimage']),
                            ),
                         ),
                        imageFileCover == null
                        ?   YellowButton(label: 'Change ?', onPressed: () {
                              pickCoverImage();
                            }, width: 0.25)
                        :   Column(
                              children: [
                                YellowButton(label: 'Change ?', onPressed: () {
                                  pickCoverImage();
                                }, width: 0.25),
                                Icon(Icons.arrow_right_alt_sharp,size: 34,color: Colors.blueGrey.shade200,),
                                YellowButton(label: 'Reset', onPressed: () {
                                  setState(() {
                                    imageFileCover = null;
                                  });
                                }, width: 0.25),
                          ],
                        ),
                        imageFileCover==null
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.yellow,
                            backgroundImage: FileImage(File(imageFileCover!.path))
                        ),
                    ],),
                    const Padding(padding: EdgeInsets.all(16),child: Divider(color: Colors.yellow,thickness: 2.5,),)
                ],),
                Column(
                  children: [
                     const Text(
                      'Other Changes',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator:(value){
                          if (value!.isEmpty){
                            return'Please enter your Store Name';
                          }
                          return null;
                        },
                        onSaved: (value){
                          storeName = value!;
                        },
                        initialValue: widget.data['storename'],
                        decoration: textFormDecoration.copyWith(
                            labelText: "store name", hintText: 'enter store name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator:(value){
                          if (value!.isEmpty){
                            return 'Please enter your Phone No.';
                          }
                          return null;
                        },
                        onSaved: (value){
                          phoneNumber = value!;
                        },
                        initialValue: widget.data['phone'],
                        decoration: textFormDecoration.copyWith(
                            labelText: "Phone No.", hintText: "Enter Phone No."),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          YellowButton(label: 'cancel', onPressed: (){Navigator.pop(context);}, width: 0.25),
                          processing == false
                          ? YellowButton(
                                label: 'save',
                                onPressed: () {
                                  saveChanges();
                                },
                                width: 0.25)
                          : const SizedBox(child: CircularProgressIndicator())
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}

var textFormDecoration  =  InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full Name please',
                        border: 
                          OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.purple, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                        );

