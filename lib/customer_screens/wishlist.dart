import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:multi_store_app/providers/cart_provider.dart";
import "package:multi_store_app/providers/wish_provider.dart";
import "package:multi_store_app/widgets/appbar_widgets.dart";
import "package:provider/provider.dart";


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor:Colors.white,
            leading: const AppBarBackButton(),
            title: const AppBarTitle(title: 'Wishlist',),
            /*actions: [
              // only show the delete button when Cart is not empty
              context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(onPressed: (){
                  MyAlertDialog.showMyDialog(
                          context: context,
                          title: 'Clear wishlist',
                          content: 'Are you sure you want to clear your wishlist?',
                          tapNo: () {
                            Navigator.pop(context);
                          },
                          tapYes: () {
                            context.read<Cart>().clearCart();
                            Navigator.pop(context);
                          });
                }, icon: 
                const Icon(
                  Icons.delete_forever,
                  color: Colors.black,)
                  )
            ],*/
        
          ),
        
          
          body: context.watch<Wish>().getWishItems.isNotEmpty
          ? const WishItems()
          : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
              "Your Wishlist is Empty !",
                style: TextStyle(fontSize: 30),
                ),
      ],)
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(builder: (context,wish,child){
        return ListView.builder(
            itemCount: wish.count,
            itemBuilder: (context,index){
              final product = wish.getWishItems[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
                child: SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width: 120,
                        child: Image.network(product.imagesUrl.first),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade700
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      product.price.toStringAsFixed(2),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red
                                    ),
                                  ),
                                Row(children: [
                                  IconButton(
                                    onPressed: (){
                                    context.read<Wish>().removeItem(product);
                                    }, 
                                    icon: const Icon(Icons.delete_forever)),
                                  const SizedBox(width: 10,),
                                  context.watch<Cart>().getItems.firstWhereOrNull((element) => element.documentId==product.documentId) !=null 
                                      ? const SizedBox()
                                      :IconButton(
                                        onPressed: (){
                                        context.read<Cart>().addItem(
                                            product.name,
                                            product.price,
                                            1,
                                            product.qntty,
                                            product.imagesUrl,
                                            product.documentId,
                                            product.suppId,
                                        );
                                      }, 
                                    icon: const Icon(Icons.add_shopping_cart))
                                ],)
                                ],
                              )
                            ],
                          ),
                        ),
                      )
    
                    ],
                  ),
                )
            ),
          );
        });
    },);
  }
}


