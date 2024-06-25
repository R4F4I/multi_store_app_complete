
import 'package:flutter/material.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: const AppBarTitle(title: 'Add Address'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding( 
              padding: const EdgeInsets.fromLTRB(10, 40, 30, 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.05,
                      child: TextFormField(
                          validator: (value){
                            if (value!.isEmpty){
                              return 'You havent entered your first name';
                            }
                            return null;
                            },
                          onChanged: (value){
                            },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'First Name',
                            hintText: 'Enter your first Name ',
                              )
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.05,
                      child: TextFormField(
                          validator: (value){
                            if (value!.isEmpty){
                              return 'You havent entered your first name';
                            }
                            return null;
                            },
                          onChanged: (value){
                            },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'First Name',
                            hintText: 'Enter your first Name ',
                            )
                          ),
                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.05,
                      child: TextFormField(
                          validator: (value){
                            if (value!.isEmpty){
                              return 'You havent entered your first name';
                            }
                            return null;
                            },
                          onChanged: (value){
                            },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'First Name',
                            hintText: 'Enter your first Name ',
                            )
                          ),
                        ),
                      ),
                ],
              ),
            ),
             Center(
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: YellowButton(
                  label: 'Add New Address',
                  onPressed: () {},
                  width:0.5,
                             ),
               ),
             ), 
        ],),
      ),
      
    );
  }
}

var textFormDecoration  =  InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Enter your first Name ',
                        border: 
                          OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.purple, width: 1),
                            borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
                              borderRadius: BorderRadius.circular(25)),
                        );
