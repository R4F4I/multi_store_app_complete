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
      body:Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.blueGrey.shade100,
                height: MediaQuery.of(context).size.width*0.5,
                width: MediaQuery.of(context).size.width*0.5,
                child: const Center(child: Text('you haven\'t picked \n \n any images yet!'),),
                )
                ],)
      ],)
    );
  }
}