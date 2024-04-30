// ignore_for_file: avoid_print, sort_child_properties_last, depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_store_app/utilities/categ_list.dart';
import 'package:multi_store_app/widgets/snackbar.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';



class EditProduct extends StatefulWidget {
  final dynamic items;
  const EditProduct({super.key, required this.items});

  @override
  State<EditProduct> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  int? discount = 0; //nullable
  String mainCategdropDownVal='select category';
  String subCategdropDownVal='subcategory';
  List<String> subCategList=[];
  bool processing = false;

// picks multiple Images,
//imagesFIleList is a list of type XFile
// the function '_pickProductImages()'  uses 'pickMultiImage()' to select multiple images
// then places them inside 'pickedImages' (which places them inside the created imagesFileList)
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  List<String> imagesUrlList = [];
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
  previewCurrentImages(){
    List<dynamic> itemImages = widget.items['proimages'];
    return ListView.builder(
      itemCount: itemImages.length,
      itemBuilder: (context,index){
        return Image.network(itemImages[index]);
    });
  }

  void selectedMainCateg(String ? value){
    if(value=='subcategory'){subCategList=[];}
    else if(value == 'men'){subCategList = men;}
    else if(value == 'women'){subCategList = women;}
    else if(value == 'electronics'){subCategList = electronics;}
    else if(value == 'accessories'){subCategList = accessories;}
    else if(value == 'shoes'){subCategList = shoes;}
    else if(value == 'home & garden'){subCategList = homeandgarden;}
    else if(value == 'beauty'){subCategList = beauty;}
    else if(value == 'kids'){subCategList = kids;}
    else if(value == 'bags'){subCategList = bags;}
  }
  // Future<void> uploadImages() async{
  //   if (mainCategdropDownVal!='select category'&& subCategdropDownVal!='subcategory'){ // '&&' since both of them should be selected
  //     if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save(); // since "onChanged" automatically saves while "onSaved" does not, we have to manually save
  //     if(imagesFileList!.isNotEmpty){
  //       // this for loop will upload each image inside the imagesFIleList to firebase,
  //       // it references each image's name by placing it in products folder 
  //       try {
  //         setState(() {
  //           processing=true; 
  //         });
  //         for (var image in imagesFileList!){
  //         firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
  //           'products/${path.basename(image.path)}' // here each image is place in products folder, it name stays the same , basename place actual name inside path, hence input: 'path/in/my/local/space/image.png' output:'products/image.png'
  //         );
  //         await ref.putFile(File(image.path)).whenComplete(() async{
  //           await ref.getDownloadURL().then((value) {
  //             imagesUrlList.add(value); // when the image files are successfully uploaded to firebase, fetch their URLs and place them inside 'imagesUrlList' 
  //           });
  //         });
  //       }
  //      } catch(e){
  //       print(e);
  //      }
  //     } else{
  //       MyMessageHandler.showSnackBar(_scaffoldKey, 'Please pick an image');}
  //   } else {
  //     MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
  //   }
  // } else { 
  //   MyMessageHandler.showSnackBar(_scaffoldKey, 'Please select categories for product');
  // }    
  // }

  // void uploadData() async{
  //   if(imagesUrlList.isNotEmpty){
  //     CollectionReference productRef = FirebaseFirestore.instance.collection('products');
  //     proId = const Uuid().v4(); // used uuid to be able to refer to a prod id to edit in future, as the ones made by firebase cant be referenced
  //             await productRef.doc(proId).set({
  //               'proid':proId,
  //               'maincateg': mainCategdropDownVal,
  //               'subcateg': subCategdropDownVal,
  //               'price': price,
  //               'instock': quantity,
  //               'proname': proName,
  //               'prodesc': proDesc,
  //               'sid': FirebaseAuth.instance.currentUser!.uid,
  //               'proimages': imagesUrlList,
  //               'discount': discount,
  //                 }).whenComplete(() {
  //               setState(() {
  //                 processing=false; // when all is complete, processing is not happening
  //                 imagesFileList=[];
  //                 imagesUrlList=[];
  //                 mainCategdropDownVal='select category';
  //                 subCategList=[];
  //                 });
  //               _formKey.currentState!.reset();
  //             });

  //   } else {
  //     print('no images');
  //   }
  // }
  // void uploadProduct() async{
  //   await uploadImages().whenComplete(() => uploadData()); // to avoid the 'incrementing' & the 'imagesUrlList not emptying' error, we split the two processes into two different functions
  // }


  Future uploadImages() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // since "onChanged" automatically saves while "onSaved" does not, we have to manually save
      if (imagesFileList!.isNotEmpty){

      if (mainCategdropDownVal!='select category'&& subCategdropDownVal!='subcategory'){
        
        try {
          setState(() {
            processing=true; 
          });
          for (var image in imagesFileList!){
          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
            'products/${path.basename(image.path)}' // here each image is place in products folder, it name stays the same , basename place actual name inside path, hence input: 'path/in/my/local/space/image.png' output:'products/image.png'
          );
          await ref.putFile(File(image.path)).whenComplete(() async{
            await ref.getDownloadURL().then((value) {
              imagesUrlList.add(value); // when the image files are successfully uploaded to firebase, fetch their URLs and place them inside 'imagesUrlList' 
            });
          });
        }
       } catch(e){
        print(e);
        }
      }else {
          MyMessageHandler.showSnackBar(_scaffoldKey, 'Please select categories for product');
        }
    }else{
        imagesUrlList = widget.items['proimages'] ;
      }
  }else{
      MyMessageHandler.showSnackBar(_scaffoldKey, 'Please fill all fields');
    }
  }

  editProductData() async{
    FirebaseFirestore.instance.runTransaction((transaction) async{
      DocumentReference documentReference = FirebaseFirestore.instance.collection('products').doc(widget.items['proid']);
      transaction.update(documentReference, {
                
                // 'maincateg': mainCategdropDownVal,
                // 'subcateg': subCategdropDownVal,
                'price': price,
                'instock': quantity,
                'proname': proName,
                'prodesc': proDesc,
                
                'proimages': imagesUrlList,
                'discount': discount,
      });
    }).whenComplete(()=> Navigator.pop(context));
  }

  void saveChanges() async{
    await uploadImages().whenComplete(()=>editProductData());    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.blueGrey.shade100,
                            height: size.width*0.5,
                            width: size.width*0.5,
                            child:previewCurrentImages()
                              ),
                          SizedBox(
                            height: size.width*0.5,
                            width: size.width*0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Column( //both wrapped in column to keep them together,
                                  children: [
                                    const Text('main category',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    // DropDownButton is one widget that contains several widgets, hence list
                                    // these widget here, are the DropDownButtonMenuItem which contains: a 'child' & 'value' 
                                    // clicking on a 'child' of DropDownButtonMenuItem uses the 'value'
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      margin: const EdgeInsets.all(6),
                                      constraints: BoxConstraints(minWidth: size.width*0.3),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text(widget.items['maincateg'])),
                                    )
                                  ],
                                ),
                                Column( //both wrapped in column to keep them together,
                                  children: [
                                    const Text('sub category',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      margin: const EdgeInsets.all(6),
                                      constraints: BoxConstraints(minWidth: size.width*0.3),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(child: Text(widget.items['subcateg'])),
                                    )
                                  ],
                                )
                            ],),
                          )
                      ],),

                    const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 30,
                              child: Divider(color: Colors.yellow,thickness: 1.5,)),
                        ),
                     ExpandablePanel(
                        header: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                            child: const Center(child: Text('Change Images & Categories',style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),))),
                        ),
                        collapsed: const SizedBox(), 
                        expanded: changeImages(size))
                    ],
                  ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 30,
                            child: Divider(color: Colors.yellow,thickness: 1.5,)),
                        ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(                                  
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: TextFormField(
                                    initialValue: widget.items['price'].toStringAsFixed(2),
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
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: TextFormField(
                                    initialValue: widget.items['discount'].toString(),
                                    maxLength: 2,
                                    validator: (value){
                                      if (value!.isEmpty){
                                        return null;
                                      }
                                      else if (value.isValidDiscount() == false){
                                        return 'invalid discount';
                                      }
                                      return null;
                                    },
                                    onSaved: (value){  //onChanged not used as it has no 'null check': (value in (value!) has nullCheck '!' ) 
                                      discount = int.parse(value!); // value is 'string', discount is 'int', (conversion)
                                    },
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    decoration: textFormDecoration.copyWith(
                                      labelText: 'discount',
                                      hintText: 'enter discount for product',
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width*0.45,
                              child: TextFormField(
                                initialValue: widget.items['instock'].toString(),
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
                                initialValue: widget.items['proname'],
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
                                initialValue: widget.items['prodesc'],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            YellowButton(label: 'cancel', onPressed:(){Navigator.pop(context);}, width:0.25),
                            YellowButton(
                              label: 'Save', 
                              onPressed:(){saveChanges();}, 
                              width:0.25),
                          ],),
                          const SizedBox(height: 15,)
                      ],),
            ),
          ),
        ),
      ),
    );
  }
  Widget changeImages(Size size){
            return Column(
              children: [
                        Row(
                          children: [
                            Container(
                              color: Colors.blueGrey.shade100,
                              height: size.width*0.5,
                              width: size.width*0.5,
                              child:imagesFileList != null
                                ?previewImages()
                                :const Center(
                                child: Text('you haven\'t picked \n \n any images yet!',
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            SizedBox(
                              height: size.width*0.5,
                              width: size.width*0.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Column( //both wrapped in column to keep them together,
                                    children: [
                                      const Text('*select main category',style: TextStyle(color: Colors.red),),
                                      // DropDownButton is one widget that contains several widgets, hence list
                                      // these widget here, are the DropDownButtonMenuItem which contains: a 'child' & 'value' 
                                      // clicking on a 'child' of DropDownButtonMenuItem uses the 'value'
                                      DropdownButton(
                                        iconSize: 40,
                                        iconEnabledColor: Colors.red,
                                        dropdownColor: Colors.yellow.shade400,
                                        value:mainCategdropDownVal, //! value here MUST exist in [DropdownMenuItem(value: )] /// aka: "DropdownButton(value) == DropdownMenuItem(value)"" /// the values within "DropdownMenuItem" MUST also be unique 
                                        items: maincateg
                                        .map<DropdownMenuItem<String>>((value){
                                          return DropdownMenuItem(child: Text(value),value: value,);
                                        }).toList(),
                                        onChanged: (String? value){
                                        print(value);
                                        setState(() {
                                          mainCategdropDownVal=value!;
                                          subCategdropDownVal='subcategory';
                                        });
                                        selectedMainCateg(value);
                                      }),
                                    ],
                                  ),
                                  Column( //both wrapped in column to keep them together,
                                    children: [
                                      const Text('*select sub category',style: TextStyle(color: Colors.red),),
                                      DropdownButton(
                                        iconSize: 40,
                                        iconEnabledColor: Colors.red,
                                        iconDisabledColor: Colors.black,
                                        dropdownColor: Colors.yellow.shade400,
                                        menuMaxHeight: 500,
                                        disabledHint: const Text('select category'),
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
                                      }),
                                    ],
                                  )
                                ],),
                              )
                              ],),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: imagesFileList!.isNotEmpty
                      ? YellowButton(
                          label: 'reset Images ?', 
                          onPressed: (){
                            setState(() {
                              imagesFileList=[];
                            });
                          }, 
                          width: 0.6
                          )
                      : YellowButton(
                          label: 'change Images', 
                          onPressed: (){
                            _pickProductImages();
                            }, 
                          width: 0.6
                          )
                    )
              ],
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

> allows decimals(optional) only upto 2 decimal place, 
e.g: 12.3: 'yes',12.34: 'yes', 12.345: 'no',

> or can start with 0 only once before decimal,
e.g: 0.9: 'yes', 01.9: 'no',

> after decimal num is neccessary,
e.g: 1.0: 'yes',1.: 'no',

 */

extension DiscountValidator on String{
  bool isValidDiscount(){
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}

/* 
above regex :

> only integers, no limit to length
> e.g: 0: 'yes', 12: 'yes', wq: 'no',

*/