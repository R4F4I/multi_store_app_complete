import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:ms_supplier_app/minor_screens/full_screen_view.dart';
import 'package:ms_supplier_app/models/product_model.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:expandable/expandable.dart';


class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({super.key, required this.proList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg',isEqualTo: widget.proList['maincateg'])
      .where('subcateg',isEqualTo: widget.proList['subcateg'])
      .snapshots();
  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('products').doc(widget.proList['proid']).collection('reviews')
      .snapshots();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  late List<dynamic> imagesList = widget.proList['proimages'];
  @override
  Widget build(BuildContext context) {
    var onSale = widget.proList['discount'];    
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreenView(imagesList: imagesList,)));
                  },
                  child: Stack(
                    children: [SizedBox(
                      height: MediaQuery.of(context).size.height*0.45,
                      child: Swiper(
                        autoplay: true,
                        pagination: const SwiperPagination(builder: DotSwiperPaginationBuilder(color: Colors.grey, activeColor: Colors.amber)),
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
                           onSale !=0
                              ?  Row(
                                children: [
                                  Text(
                                      ('USD ')+widget.proList['price'].toStringAsFixed(2), //original price
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                  const SizedBox(width: 6,),
                                  Text(
                                      ('USD ')+((1-(onSale/100))*widget.proList['price']).toStringAsFixed(2)+(' !!!'), //discounted price
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600
                                        ),
                                      ),
                                  ],
                              )
                              : Text(
                                  ('USD ')+widget.proList['price'].toStringAsFixed(2), //original price
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                          
                        ],),
                        widget.proList['instock']==0
                        ? const Text((' This Item is out of stock'),
                            style:  TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                ),
                              )
                        : Text((widget.proList['instock'].toString())+(' pieces left in stock'),
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
                        review(reviewsStream),
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

Widget review(reviewsStream){
  return ExpandablePanel(
    header: const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text('Reviews',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),
    ),
    collapsed: SizedBox(height: 130,child: reviewsAll(reviewsStream),), 
    expanded: reviewsAll(reviewsStream));
}

Widget reviewsAll(var reviewsStream){
  return StreamBuilder<QuerySnapshot>(
      stream: reviewsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {

        if (snapshot2.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot2.data!.docs.isEmpty){ //when a section, filtered with '.where(,isEqualTo: )' returns an empty output
          return const Center(child: Text(
            'This product has no reviews yet!',
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
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context,index){
            return ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(snapshot2.data!.docs[index]['profileimage']),
                ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot2.data!.docs[index]['rate'].toString()),
                      const Icon(Icons.star,color: Colors.amber,)
                      ],
                     )
                  ],),
              subtitle: Text(snapshot2.data!.docs[index]['comment']),
              );

        });
      },
    );
}