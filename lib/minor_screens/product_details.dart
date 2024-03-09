import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/models/product_model.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';


class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({super.key, required this.proList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late List<dynamic> imagesList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = 
      FirebaseFirestore.instance
        .collection('products')
        .where('maincateg',isEqualTo: widget.proList['maincateg'])
        .where('subcateg',isEqualTo: widget.proList['subcateg'])
        .snapshots();
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: [SizedBox(
                  height: MediaQuery.of(context).size.height*0.45,
                  child: Swiper(
                    pagination: const SwiperPagination(builder: SwiperPagination.fraction),
                    itemBuilder: (context,index){
                    return Image(image: NetworkImage(imagesList[index]),);
                  }, 
                    itemCount: imagesList.length,
                    ),
                  ),
                Positioned(
                  left: 15,
                  top: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.black,), 
                      onPressed: () { 
                        Navigator.pop(context);
                       },
                      ),
                    )
                  ),
                  Positioned(
                  right: 15,
                  top: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    child: IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Colors.black,), 
                      onPressed: () {},
                      ),
                    )
                  ),
                ],
              ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,8,50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.proList['proname'],
                       style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                      children: [
                         Row(
                          children: [
                            const Text('USD  ',style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(widget.proList['price'].toStringAsFixed(2),style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){}, 
                          icon: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                            size: 30,
                            ),
                          ),
                        
                      ],),
                      Text((widget.proList['instock'].toString())+(' pieces left in stock'),
                          style:  const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              ),
                            ),
                      const ProductDetailsHeaderLabel(label: '  Item Description  ',),
                      Text(widget.proList['prodesc'],
                        style: TextStyle(
                          color: Colors.blueGrey.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const ProductDetailsHeaderLabel(label: '  Recommended Items  ',),
                        SizedBox(child: StreamBuilder<QuerySnapshot>(
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
                      ),
                    ),],
                  ),
                )
              ],),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.store)),
                  const SizedBox(width: 20,),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart_sharp)),
                ],
              ),
              YellowButton(label: 'Add to Cart'.toUpperCase(), onPressed: (){}, width: 0.5),
            ],),
          ),
          ),
      ),
    );
  }
}

class ProductDetailsHeaderLabel extends StatelessWidget {
  final String label;
  const ProductDetailsHeaderLabel({
    super.key, required this.label
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 60,child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40,width: 50,child: Divider(color: Colors.yellow.shade900,thickness: 1,)),
        Text(label, style: TextStyle(color: Colors.yellow.shade900,fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 40,width: 50,child: Divider(color: Colors.yellow.shade900,thickness: 1,)),
    ]),
            );
  }
}