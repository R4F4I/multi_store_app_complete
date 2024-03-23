import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:multi_store_app/providers/cart_provider.dart";
import "package:multi_store_app/widgets/appbar_widgets.dart";
import "package:multi_store_app/widgets/yellow_button.dart";
import "package:provider/provider.dart";

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.watch<Cart>().totalPrice;
    double totalPaid  = context.watch<Cart>().totalPrice + 10.0;
    return 
    
    FutureBuilder<DocumentSnapshot>(
      future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {return const Text("Something went wrong");}
        if (snapshot.hasData && !snapshot.data!.exists) {return const Text("Document does not exist");}

        if (snapshot.connectionState ==ConnectionState.waiting){
          return const Material(child: Center(child: CircularProgressIndicator(),),);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return 
            Material(
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.grey.shade200,
                      leading: const AppBarBackButton(),
                      title: const AppBarTitle(
                        title: 'Payment'
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [                                    
                                      const Text('Total ',style: TextStyle(fontSize: 20),),
                                      Text('${totalPaid.toStringAsFixed(2)} USD',style: const TextStyle(fontSize: 20),),
                                  ],),
                                  const Divider(color: Colors.grey,thickness: 2,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [                                    
                                      const Text('Total Price ',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                      Text('${totalPrice.toStringAsFixed(2)} USD',style: const TextStyle(fontSize: 16,color: Colors.grey),),
                                  ],),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [                                    
                                      Text('Shipping Cost ',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                      Text('10.00 USD',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                  ],),
                                ]),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Column(children: [
                                RadioListTile(
                                  value: 1, 
                                  groupValue: selectedValue,
                                  onChanged: (int ?value){
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Cash On Delivery'),
                                  subtitle: const Text('Pay via Cash'),
                                ),
                                RadioListTile(
                                  value: 2, 
                                  groupValue: selectedValue,
                                  onChanged: (int ?value){
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Pay via Visa / MasterCard'),
                                  subtitle: const Row(
                                    children: [
                                      Icon(Icons.payment,color: Colors.blue,size: 30,),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Icon(FontAwesomeIcons.ccMastercard,color: Colors.blue,),
                                      ),
                                      Icon(FontAwesomeIcons.ccVisa,color: Colors.blue,)
                                      ],)
                                ),
                                RadioListTile(
                                  value: 3, 
                                  groupValue: selectedValue,
                                  onChanged: (int ?value){
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Pay via PayPal'),
                                  subtitle: const Row(
                                    children: [
                                      Icon(FontAwesomeIcons.paypal,color: Colors.blue,),
                                      SizedBox(width: 15,),
                                      Icon(FontAwesomeIcons.ccPaypal,color: Colors.blue,),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                      ],),
                    ),
                    bottomSheet: Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: YellowButton(
                          label: 'Confirm ${totalPaid.toStringAsFixed(2)} USD',
                          width: 1,
                          onPressed: (){print(selectedValue);},
                        ),
                      ),
                    ),
                          ),
              ),
            );
        } 
      return const Center(
          child: CircularProgressIndicator(),
      );
    });
  }
}

