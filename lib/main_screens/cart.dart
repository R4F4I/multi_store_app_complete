import "package:flutter/material.dart";
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor:Colors.white,
            leading: widget.back,
            title: const AppBarTitle(title: 'Cart',),
            actions: [
              IconButton(onPressed: (){}, icon: 
              const Icon(
                Icons.delete_forever,
                color: Colors.black,)
                )
            ],
        
          ),
        
          
          body: Consumer<Cart>(builder: (context,cart,child){
            return ListView.builder(
                itemCount: cart.count,
                itemBuilder: (context,index){
              return Text(cart.getItems[index].price.toString());
            });
          },),

          /*Center(
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
          ),*/
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Row(
                 children: [
                   Text("total: \$ ", style: TextStyle(fontSize: 18),),
                   Text("00.00", 
                   style: TextStyle(
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


