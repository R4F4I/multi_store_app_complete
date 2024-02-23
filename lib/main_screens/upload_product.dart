import 'package:flutter/material.dart';


class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
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
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price of a unit item',
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: TextFormField(
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price of a unit item',
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: TextFormField(
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price of a unit item',
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.4,
                          child: TextFormField(
                            decoration: textFormDecoration.copyWith(
                              labelText: 'price',
                              hintText: 'price of a unit item',
                            )
                          ),
                        ),
                      ),
                  ],),
        ),
      )
    );
  }
}





var textFormDecoration =  InputDecoration(
                              labelText: 'price',
                              hintText: 'price of a unit item',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.yellow, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                              );