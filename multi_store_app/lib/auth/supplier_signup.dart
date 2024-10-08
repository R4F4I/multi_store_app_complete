//import 'dart:ffi';

// ignore_for_file: avoid_print,


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/providers/auth_repo.dart';
import 'package:multi_store_app/widgets/auth_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SupplierRegister extends StatefulWidget {
  const SupplierRegister({super.key});

  @override
  State<SupplierRegister> createState() => _SupplierRegisterState();
}

class _SupplierRegisterState extends State<SupplierRegister> {
  
// ignore: unused_field
XFile? _imageFile;
dynamic _pickedImageError;


final ImagePicker _picker = ImagePicker();

  late String storeName;
  late String email;
  late String password;
  late String storeLogo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = false;
  bool processing = false;

CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');
late String _uid;


void _pickImageFromCamera ()async{
  try{
    final pickedImage= await _picker.pickImage(
    source: ImageSource.camera,
    maxHeight: 300,
    maxWidth: 300,
    imageQuality: 95);
    setState(() {
      _imageFile = pickedImage;
    });
  }catch(e){
    setState(() {
      _pickedImageError = e;
    });
    print(_pickedImageError);
  }
   
}

void _pickImageFromGallery ()async{
  try{
    final pickedImage= await _picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 300,
    maxWidth: 300,
    imageQuality: 95);
    setState(() {
      _imageFile = pickedImage;
    });
  }catch(e){
    setState(() {
      _pickedImageError = e;
    });
    print(_pickedImageError);
  }
   
}

void signUp() async {
  setState(() {
    processing=true;
  });
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        try{
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password);

        

        firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage
        .instance.ref('supp-images/$email.jpg');
        
        await ref.putFile(File(
          _imageFile!.path
          ));

        storeLogo = await ref.getDownloadURL();

        _uid = FirebaseAuth.instance.currentUser!.uid;

         AuthRepo.updateDisplayName(storeName);
         AuthRepo.updateProfileImage(storeLogo);
        
        await suppliers.doc(_uid).set({
          'storename':storeName,
          'email':email,
          'storelogo':storeLogo,
          'phone':'',
          //'address':'',
          'sid':_uid, // supplier_i.d
          'coverimage':'',
        });
        
        _formKey.currentState!.reset();
        setState(() {
          _imageFile=null;
          });

        await Future.delayed(const Duration(microseconds: 100)).whenComplete(()=>Navigator.pushReplacementNamed(context, '/supplier_login'));

        } on FirebaseAuthException catch(e){
            setState(() {processing = false;});
            MyMessageHandler.showSnackBar(_scaffoldKey,e.message.toString());
        }
        
      } 
      else {
        setState(() {processing=false;});
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Please pick an Image first ');}
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
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const AuthHeaderLabel(headerLabel: 'Sign Up',),
                    Row(children: [
                      Padding(
                        padding:const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                        child: CircleAvatar(
                          backgroundColor: Colors.purpleAccent,
                          radius: 60,
                          backgroundImage: _imageFile==null?null: FileImage(File(_imageFile!.path)),
                          ),
                      ),
                  
                      Column(children: [
                  
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_rounded, 
                                color: Colors.white,), 
                            onPressed: () { 
                              _pickImageFromCamera();
                             },),
                            ),
                  
                        const SizedBox(height: 6,),
                  
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.photo, 
                                color: Colors.white,), 
                            onPressed: () { 
                              _pickImageFromGallery();
                             },),
                            ),
                  
                      ],)
                    ],),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value){
                          if (value!.isEmpty){
                            return 'You havent entered your full name';
                          }
                          return null;
                        },
                        onChanged: (value){
                          storeName=value;
                        },
                       
      
                        decoration: textFormDecoration.copyWith(
                          labelText: 'Full Name',
                          hintText: 'Enter your full Name please',)
                         
                          
                          ),
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
                     HaveAccount(
                      haveAccount: 'Already have Account?',
                      actionLabel: 'Log In',
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/supplier_login');
                      },
                    ),
                  
                     processing == true
                     ? const Center(child: CircularProgressIndicator())
                     : AuthMainButton(
                       mainButtonLabel: 'Sign Up',
                        onPressed: (){signUp();},
                    ),
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

