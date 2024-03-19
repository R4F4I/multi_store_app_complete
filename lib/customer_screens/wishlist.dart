import "package:flutter/material.dart";
import "package:multi_store_app/models/wish_model.dart";
import "package:multi_store_app/providers/wish_provider.dart";
import "package:multi_store_app/widgets/alert_dialog.dart";
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
            actions: [
              // only show the delete button when wishlist is not empty
              context.watch<Wish>().getWishItems.isEmpty
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
                            context.read<Wish>().clearWishlist();
                            Navigator.pop(context);
                          });
                }, icon: 
                const Icon(
                  Icons.delete_forever,
                  color: Colors.black,)
                  )
            ],
        
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
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey
                  ),
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
          return WishlistModel(product: product);
        });
    },);
  }
}