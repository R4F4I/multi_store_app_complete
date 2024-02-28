// ignore_for_file: avoid_print, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/widgets/snackbar.dart';

List <String> mainCategList = ['select category','men','women','shoes','bags'];
List <String>   menSubCateg = ['subcategory'    ,   'shirt',   'jacket',   'vest',   'coat'];
List <String> womenSubCateg = ['subcategory'    , 'w shirt', 'w jacket', 'w vest', 'w coat'];
List <String> shoesSubCateg = ['subcategory'    ,'sh shirt','sh jacket','sh vest','sh coat'];
List <String>  bagsSubCateg = ['subcategory'    ,' b shirt', 'b jacket', 'b vest', 'b coat'];



class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  String mainCategdropDownVal='select category';
  String subCategdropDownVal='subcategory';
  List<String> subCategList=[];

// picks mulitple Images,
//imagesFIleList is a list of type XFile
// the function '_pickProductImages()'  uses 'pickMultiImage()' to select multiple images
// then places them inside 'pickedImages' (which places them insde the created imagesFileList)
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  dynamic _pickedImageError;

  void _pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages; // incase, add: 'pickedImages!'
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

// shows multiple images present inside imagesFileList
  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imagesFileList![index].path));
          });
    } 
    else { 
      // when the delete icon is pressed, it does not show the initial empty text, hence we add this
      return const Center(
        child: Text(
          'you haven\'t picked \n \n any images yet!',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  void uploadProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // since "onChanged" automatically saves while "onSaved" does not, we have to manually save
      if(imagesFileList!.isNotEmpty){
        print('images picked!'); // image validation   
        print('valid');
        print(price);
        print(quantity);
        print(proName);
        print(proDesc);
        // after successful attempt, clear all fields
        imagesFileList=[];
        _formKey.currentState!.reset();

      } else{
        MyMessageHandler.showSnackBar(_scaffoldKey, 'Please pick an image');
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body:SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: MediaQuery.of(context).size.width*0.5,
                        width: MediaQuery.of(context).size.width*0.5,
                        child:imagesFileList != null
                          ?previewImages()
                          :const Center(
                          child: Text('you haven\'t picked \n \n any images yet!',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        Column(children: [
                          const Text('select main category'),
                          // DropDownButton is one widget that contains several widgets, hence list
                          // these widget here, are the DropDownButtonMenuItem which contains: a 'child' & 'value' 
                          // clicking on a 'child' of DropDownButtonMenuItem uses the 'value'
                          DropdownButton(
                            value:mainCategdropDownVal, //! value here MUST exist in [DropdownMenuItem(value: )] /// aka: "DropdownButton(value) == DropdownMenuItem(value)"" /// the values within "DropdownMenuItem" MUST also be unique 
                            items: mainCategList
                            .map<DropdownMenuItem<String>>((value){
                              return DropdownMenuItem(child: Text(value),value: value,);
                            }).toList(),
                            onChanged: (String? value){
                            print(value);
                            setState(() {
                              mainCategdropDownVal=value!;
                              subCategdropDownVal='subcategory';
                            });
                            if(value == 'men'){
                              subCategList=menSubCateg;
                            }
                            else if(value == 'women'){
                              subCategList=womenSubCateg;
                            }
                            else if(value == 'shoes'){
                              subCategList=shoesSubCateg;
                            }
                            else if(value == 'bags'){
                              subCategList=bagsSubCateg;
                            }
                          }),
                          const Text('select sub category'),
                          
                          DropdownButton(
                            value:subCategdropDownVal, 
                            items: subCategList
                            .map<DropdownMenuItem<String>>((value){
                              return DropdownMenuItem(child: Text(value),value: value,);
                            }).toList(),
                            onChanged: (String? value){
                            print(value);
                            setState(() {
                              subCategdropDownVal=value!;
                            });
                          })
                        ],)
                        ],),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 30,
                            child: Divider(color: Colors.yellow,thickness: 1.5,)),
                        ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: TextFormField(
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'please enter price';
                                  }
                                  else if (value.isValidPrice() == false){
                                    return 'invalid Price';
                                  }
                                  return null;
                                },
                                onSaved: (value){  //onChanged not used as it has no 'null check': (value in (value!) has nullCheck '!' ) 
                                  price = double.parse(value!); // value is 'string', price is 'double', (conversion)
                                },
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                decoration: textFormDecoration.copyWith(
                                  labelText: 'price',
                                  hintText: 'enter price of product',
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.45,
                              child: TextFormField(
                                 validator: (value){
                                  if (value!.isEmpty){
                                    return 'please enter Quantity';
                                  }
                                  else if (value.isValidQuantity() == false){
                                    return 'invalid quantity';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  quantity = int.parse(value!); // value is 'string', quantity is 'int', (conversion)
                                },
                                keyboardType: const TextInputType.numberWithOptions(),
                                decoration: textFormDecoration.copyWith(
                                  labelText: 'Quantity',
                                  hintText: 'Enter Quantity',
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                 validator: (value){
                                  if (value!.isEmpty){
                                    return 'please enter product Name';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  proName = value!; // no conversion needed,
                                },
                                maxLength: 100,
                                maxLines: 3,
                                decoration: textFormDecoration.copyWith(
                                  labelText: 'product Name',
                                  hintText: 'Enter product Name',
                                )
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                 validator: (value){
                                  if (value!.isEmpty){
                                    return 'please enter product Description';
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  proDesc = value!; // no conversion needed,
                                },
                                maxLength: 800,
                                maxLines: 5,
                                decoration: textFormDecoration.copyWith(
                                  labelText: 'product Description',
                                  hintText: 'provide product Description',
                                )
                              ),
                            ),
                          ),
                      ],),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: 
            FloatingActionButton(
              //shape: const CircleBorder(),
              onPressed: imagesFileList!.isEmpty 
              ?(){ 
                _pickProductImages();
                } 
              :(){
                setState(() {
                  imagesFileList=[];
                });
              },
              backgroundColor: Colors.yellow,
              child: imagesFileList!.isEmpty 

              ?const Icon(Icons.photo_library,
                color: Colors.black,)
              
              :const Icon(Icons.delete_forever, //to allow user to remove & pick images with the same button
                color: Colors.black,),
                ),
              ),
            FloatingActionButton(
              //shape: const CircleBorder(),
              onPressed: (){
                uploadProduct();
              },
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.upload,
                color: Colors.black,) ,),
        ]),
      ),
    );
  }
}





var textFormDecoration =  InputDecoration(
    labelText: 'price',
    hintText: 'price of a unit item',
    labelStyle: const TextStyle(color: Colors.purple),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.yellow, width: 1),
      borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
      borderRadius: BorderRadius.circular(10)),
    );

extension QuantityValidator on String{
  bool isValidQuantity(){
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}
/* 
above regex: 
> only allows integers, 
e.g: 12: 'yes', 12.3: 'no',

> single digit int must not be 0,
e.g: 12: 'yes', 012 : 'no',

> 2nd & digits beyond that, are optional
e.g: 1,12,123,1234, ... 
 */


extension PriceValidator on String{
  bool isValidPrice(){
    return RegExp(r'^(((([1-9][0-9]*)[\.]*)||([0][\.]*))([0-9]{1,2}))$').hasMatch(this);
  }
}

/* 
above regex :
> qualities of prev. +

> allows decimals(optional) only upto 2 decmial place, 
e.g: 12.3: 'yes',12.34: 'yes', 12.345: 'no',

> or can start with 0 only once before decimal,
e.g: 0.9: 'yes', 01.9: 'no',

> after decimal num is neccessary,
e.g: 1.0: 'yes',1.: 'no',

 */