import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:multi_store_app/widgets/alert_dialog.dart";
import "package:multi_store_app/widgets/appbar_widgets.dart";
import "package:multi_store_app/widgets/yellow_button.dart";
import "package:provider/provider.dart";

import "../providers/cart_provider.dart";

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            elevation: 0,
            backgroundColor:Colors.white,
            leading: widget.back,
            title: const AppBarTitle(title: 'Cart',),
            actions: [
              // only show the delete button when Cart is not empty
              context.watch<Cart>().getItems.isEmpty
              ? const SizedBox()
              : IconButton(onPressed: (){
                  MyAlertDialog.showMyDialog(
                          context: context,
                          title: 'Clear Cart',
                          content: 'Are you sure you want to clear your cart?',
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
            ],
        
          ),
        
          
          body: context.watch<Cart>().getItems.isNotEmpty
          ? const CartItems()
          : const EmptyCart(),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                 children: [
                   const Text("total: \$ ", style: TextStyle(fontSize: 18),),
                   Text(
                      context.watch<Cart>().totalPrice.toStringAsFixed(2), 
                   style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),),
                ],
              ),
              
               YellowButton(
                label: 'CHECKOUT',
                onPressed: () {},
                width: 0.45,
                ),
            ],
            
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text(
              "Your Cart is Empty !",
                style: TextStyle(fontSize: 30),
                ),
          const SizedBox(height: 50,
                ),
          Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(25),
    
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width*0.6,
              onPressed: (){
                Navigator.canPop(context)
                  ?Navigator.pop(context)
                  :Navigator.pushReplacementNamed(context, '/customer_home');          
              },
    
              child: const Text("continue Shopping",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white)
                    ),
          ),
        )
      ],)
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context,cart,child){
        return ListView.builder(
            itemCount: cart.count,
            itemBuilder: (context,index){
              final product = cart.getItems[index];
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
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        product.qty==1
                                        ? IconButton(
                                            onPressed: (){
                                              cart.removeItem(product);
                                            },
                                            icon: const Icon(
                                                Icons.delete_forever,
                                            )
                                        )
                                        : IconButton(
                                            onPressed: (){
                                              cart.decrement(product);
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.minus,
                                              size: 18,
                                            )
                                        ),
                                        Text(
                                          product.qty.toString(),
                                          style: product.qty == product.qntty
                                            ? const TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Acme',
                                              color: Colors.red
                                          )
                                            :const TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Acme',
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: product.qty == product.qntty
                                            ? null
                                            : (){
                                              cart.increment(product);
                                            },
                                            icon: const Icon(
                                              FontAwesomeIcons.plus,
                                              size: 18,
                                            )
                                        ),
                                      ],
                                    ),
                                  )
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


