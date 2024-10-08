import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ms_customers_app/models/product_model.dart';
import 'package:ms_customers_app/widgets/appbar_widgets.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SubCategProducts extends StatefulWidget {
  final String subcategName;
  final String maincategName;
  final bool fromOnBoarding;

  const SubCategProducts({super.key, required this.subcategName, required this.maincategName, this.fromOnBoarding = false});

  @override
  State<SubCategProducts> createState() => _SubCategProductsState();
}
class _SubCategProductsState extends State<SubCategProducts> {
  @override
  Widget build(BuildContext context) {
     final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg',isEqualTo: widget.maincategName)
        .where('subcateg',isEqualTo: widget.subcategName)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: widget.fromOnBoarding == true 
        ?IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/customer_home');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new, 
            color: Colors.black
            )
          )
        : const AppBarBackButton(),
          

        title: AppBarTitle(title: widget.subcategName)
        
        ),

      body: StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data!.docs.isEmpty){ //when a section, filtered with '.where(,isEqualTo: )' returns an empty output
          return const Center(child: Text(
            'This category has \n \n no items yet!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontFamily: 'Acme',
              letterSpacing: 1.5,
              color: Colors.blueGrey,
            ),
            ));
        }
        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            crossAxisCount: 2, 
            itemBuilder: (context,index){
              return ProductModel(products: snapshot.data!.docs[index]);
            }, 
            staggeredTileBuilder: (context)=>const StaggeredTile.fit(1)),
        );
      },
    )
    );
  }
}

