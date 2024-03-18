import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/main_screens/visit_store.dart';
import 'package:multi_store_app/minor_screens/full_screen_view.dart';
import 'package:multi_store_app/models/product_model.dart';
import 'package:multi_store_app/providers/cart_provider.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/snackbar.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';


class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({super.key, required this.proList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
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
                            onPressed: (){
                              context.read<Wish>().getWishItems.firstWhereOrNull((product) => product.documentId==widget.proList['proid']) !=null
                              ? context.read<Wish>().removeThis(widget.proList['proid']) //now reclicking the heart icon removes the product from wishlist
                              : context.read<Wish>().addWishItem(          
                                  widget.proList['proname'],
                                  widget.proList['price'],
                                  1,
                                  widget.proList['instock'],
                                  widget.proList['proimages'],
                                  widget.proList['proid'],
                                widget.proList['sid'],
                              );
                            },
                            icon: context.watch<Wish>().getWishItems.firstWhereOrNull((product) => product.documentId==widget.proList['proid']) !=null
                              ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                              )
                              : const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 30,
                              )
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
                    IconButton(
                        onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>VisitStore(
                                  suppID: widget.proList['sid']
                              )
                          ));
                      },
                        icon: const Icon(Icons.store)
                    ),
                    const SizedBox(width: 20,),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartScreen(back: AppBarBackButton(),)));
                    }, icon: const Icon(Icons.shopping_cart_sharp)),
                  ],
                ),
                YellowButton(
                    label: 'Add to Cart'.toUpperCase(),
                    onPressed: (){
                      context.read<Cart>().getItems.firstWhereOrNull((product) => product.documentId==widget.proList['proid']) !=null 
                      // above line checks documentId of each prod. obj. in cart list, and 
                      // compares it with documentId of the current Item pressed on, 
                      //if they are same, the snackbar pops, else addItem
                      ? MyMessageHandler.showSnackBar(_scaffoldKey,'this item is already in your cart')
                      : context.read<Cart>().addItem(          
                          widget.proList['proname'],
                          widget.proList['price'],
                          1,
                          widget.proList['instock'],
                          widget.proList['proimages'],
                          widget.proList['proid'],
                        widget.proList['sid'],
                      );
                    },
                    width: 0.5),
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