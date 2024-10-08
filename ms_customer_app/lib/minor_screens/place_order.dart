import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:ms_customer_app/customer_screens/add_address.dart";
import "package:ms_customer_app/customer_screens/address_book.dart";
import "package:ms_customer_app/minor_screens/payment_screen.dart";
import "package:ms_customer_app/providers/cart_provider.dart";
import "package:ms_customer_app/widgets/appbar_widgets.dart";
import "package:ms_customer_app/widgets/yellow_button.dart";
import "package:provider/provider.dart";

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
      .collection('customers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('address')
      .where('default', isEqualTo: true)
      .limit(1)
      .snapshots();
      late String name;
      late String phone;
      late String address;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: addressStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(child: Center(child: CircularProgressIndicator()));
        }
        /* if (snapshot.data!.docs.isEmpty){ //when a section, filtered with '.where(,isEqualTo: )' returns an empty output
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
        } */
          return Material(
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      leading: const AppBarBackButton(),
                      title: const AppBarTitle(
                        title: 'Place Order'
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                      child: Column(
                        children: [
                          snapshot.data!.docs.isEmpty
                          ? GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddAddress()));
                              },
                              child: Container(
                                height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                child: const Center(
                                  child: Text(
                                    'Create New Address',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Acme',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        color: Colors.blueGrey),
                                  ),
                                ),
                              ),
                          )
                          : GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddressBook()));
                              },
                              child: Container(
                                height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var customer = snapshot.data!.docs[index] ;
                                     address = customer['city']+', '+customer['state']+', '+customer['country'];
                                     phone = customer['phone'];
                                     name = customer['firstname']+' - '+customer['lastname'];
                                    return ListTile(
                                        title: SizedBox(
                                          height: 50,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Text('${customer['firstname']} - ${customer['lastname']}'),
                                            
                                            Text(customer['phone']),
                                          ],),
                                        ),
                                        subtitle: SizedBox(
                                          height: 50,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Text('city/state: ${customer['city']}, ${customer['state']}'),
                                            
                                            Text(customer['country']),
                                              ],),
                                            ),
                                          );
                                  }
                                ),
                              ),
                          ),
                          const SizedBox(height: 20,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                              ),
                                child: Consumer<Cart>(
                                  builder: (context,cart,child){
                                  return ListView.builder(
                                    itemCount: cart.count,
                                    itemBuilder: (context,index){
                                      final order = cart.getItems[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 0.3),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Row(children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(order.imagesUrl.first),
                                              ),
                                            ),
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    order.name, 
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey.shade600),
                                                    ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          order.price.toStringAsFixed(2), 
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey.shade600),
                                                          ),
                                                        Text(
                                                          ' x ${order.qty.toString()}', 
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey.shade600),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            )
                                        ]),
                                      ),
                                    );
                                  });
                                }),
                            ),
                          ),
                      ],),
                    ),
                    bottomSheet: Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: YellowButton(
                          label: 'Confirm ${context.watch<Cart>().totalPrice.toStringAsFixed(2)} USD',
                          width: 1,
                          onPressed:  (){
                             snapshot.data!.docs.isEmpty
                              ? Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddAddress()))
                              : Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen(name: name,phone: phone,address: address,)),);
                          },
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}


