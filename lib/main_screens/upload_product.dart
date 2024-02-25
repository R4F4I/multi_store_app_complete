// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/snackbar.dart';


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

  void uploadProduct() {
    _formKey.currentState!.save(); // since "onChanged" automatically saves while "onSaved" does not, we have to manually save
    print('valid');
    print(price);
    print(quantity);
    print(proName);
    print(proDesc);
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
                        child: const Center(
                          child: 
                            Text('you haven\'t picked \n \n any images yet!',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
              
                        
                        ),
                        ),
                        )
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
              onPressed: (){},
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.photo_library,
                color: Colors.black,) ,),
          ),
            FloatingActionButton(
              //shape: const CircleBorder(),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                 uploadProduct();
                }
                else {
                  MyMessageHandler.showSnackBar(_scaffoldKey,'Please fill all fields');
                }
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