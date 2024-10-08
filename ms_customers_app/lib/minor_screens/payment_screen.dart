// ignore_for_file: avoid_print, use_build_context_synchronously

import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:ms_customers_app/providers/cart_provider.dart";
import "package:ms_customers_app/providers/stripe_id.dart";
import "package:ms_customers_app/widgets/appbar_widgets.dart";
import "package:ms_customers_app/widgets/yellow_button.dart";
import "package:provider/provider.dart";
import "package:uuid/uuid.dart";
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String address;
  const PaymentScreen({super.key, required this.name,required this.address,required this.phone});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  int selectedValue = 1;
  late String orderId;
  void showProgress(){
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(max: 100,msg:'Please Wait...',progressBgColor: Colors.red);
  }

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
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
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
                          onPressed: () async{
                            if (selectedValue==1){
                              showModalBottomSheet(
                                context: context, 
                                builder: (context)=>SizedBox(
                                  height: MediaQuery.of(context).size.height*0.3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                      Text(
                                        'Pay with Cash \$ ${totalPaid.toStringAsFixed(2)} ?',
                                        style: const TextStyle(fontSize: 24) ,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: YellowButton(
                                          label: 'Confirm Payment?', 
                                          onPressed: () async{
                                            showProgress();
                                            //if (!mounted) return;  //* USE THIS IN ASYNC BUILDCONTEXT https://dart.dev/tools/linter-rules/use_build_context_synchronously
                                            for (var item in context.read<Cart>().getItems){
                                              CollectionReference orderRef = FirebaseFirestore.instance.collection('orders');
                                              orderId = const Uuid().v4();
                                              await orderRef.doc(orderId).set({

                                                'cid': data['cid'],
                                                'custname': widget.name,
                                                'email': data['email'],
                                                'address': widget.address,
                                                'phone': widget.phone,
                                                'profileimage': data['profileimage'],

                                                'sid': item.suppId,

                                                'proid': item.documentId,
                                                'orderid': orderId,
                                                'orderimage': item.imagesUrl.first,
                                                'orderqty':item.qty,
                                                'orderprice': item.qty*item.price,
                                                'ordername':item.name,

                                                'deliverystatus': 'preparing',
                                                'deliverydate':'',
                                                'orderdate':DateTime.now(),
                                                'paymentstatus':'cash on delivery',
                                                'orderreview':false,

                                              }).whenComplete(() async{
                                                await FirebaseFirestore.instance.runTransaction((transaction) async{
                                                  DocumentReference documentReference = FirebaseFirestore.instance.collection('products').doc(item.documentId);
                                                  DocumentSnapshot snapshot2 = await transaction.get(documentReference);
                                                  transaction.update(documentReference, {'instock':snapshot2['instock'] - item.qty});
                                                });
                                              });
                                            }
                                            if (!context.mounted) return;
                                            context.read<Cart>().clearCart();
                                            Navigator.popUntil(context,ModalRoute.withName('/customer_home'));
                                          }, 
                                          width: 0.9,),
                                      )
                                    ]),
                                  ),
                                  )
                                );
                            }
                            else if (selectedValue==2){

                              // convert dollar to cents
                              int payment = (totalPaid.round())*100;
                              makePayment(data, payment.toString());
                            }
                            else if (selectedValue==3){print('paypal');}
                          },
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

  Map<String,dynamic>? paymentIntentData; 

  Future<void> makePayment(dynamic data, String total) async{
    // createPaymentIntent
    // initPaymentSheet
    // displayPaymentSheet

    paymentIntentData = await createPaymentIntent(total, 'USD');
    await initPaymentSheet();
    await displayPaymentSheet(data);

  }
  
  createPaymentIntent(String total, String currency) async{
    Map<String,dynamic> body = {
      'amount': total,
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'content_type': "application/x-www-form-urlencoded"
        }

    );
    return jsonDecode(response.body);

  }

  initPaymentSheet() async{
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'ANNIE',
          paymentIntentClientSecret: paymentIntentData?['client_secret'],
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),

        )
      );
  }
  displayPaymentSheet(var data)async{
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async{
        paymentIntentData = null;
        print('paid');
        
        // upload to firebase
        showProgress();
        //if (!mounted) return;  //* USE THIS IN ASYNC BUILDCONTEXT https://dart.dev/tools/linter-rules/use_build_context_synchronously
        for (var item in context.read<Cart>().getItems){
          CollectionReference orderRef = FirebaseFirestore.instance.collection('orders');
          orderId = const Uuid().v4();
          await orderRef.doc(orderId).set({

            'cid': data['cid'],
            'custname': widget.name,
            'email': data['email'],
            'address': widget.address,
            'phone': widget.phone,
            'profileimage': data['profileimage'],

            'sid': item.suppId,

            'proid': item.documentId,
            'orderid': orderId,
            'orderimage': item.imagesUrl.first,
            'orderqty':item.qty,
            'orderprice': item.qty*item.price,
            'ordername':item.name,

            'deliverystatus': 'preparing',
            'deliverydate':'',
            'orderdate':DateTime.now(),
            'paymentstatus':'paid online',
            'orderreview':false,

          }).whenComplete(() async{
            await FirebaseFirestore.instance.runTransaction((transaction) async{
              DocumentReference documentReference = FirebaseFirestore.instance.collection('products').doc(item.documentId);
              DocumentSnapshot snapshot2 = await transaction.get(documentReference);
              transaction.update(documentReference, {'instock':snapshot2['instock'] - item.qty});
            });
          });
        }
        context.read<Cart>().clearCart();
        Navigator.popUntil(context,ModalRoute.withName('/customer_home'));
      });

    } catch (e) {
      print('stripe presentation error:${e.toString()}');
    }
  }
}

