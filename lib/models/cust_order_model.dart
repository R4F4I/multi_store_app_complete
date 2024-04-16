import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';

class CustomerOrderModel extends StatefulWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, required this.order});

  @override
  State<CustomerOrderModel> createState() => _CustomerOrderModelState();
}

class _CustomerOrderModelState extends State<CustomerOrderModel> {

  late double rate = 1;
  late String comment = '';
  var processing = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                          borderRadius: BorderRadius.circular(15)
                        ),
                  child: ExpansionTile(
                          title: Container(
                            constraints: const BoxConstraints(maxHeight: 80),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(maxHeight: 80, maxWidth: 80),
                                      child: Image.network(widget.order['orderimage']),
                                    ),
                                ),
                                Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(
                                        widget.order['ordername'],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text(('\$ ')+(widget.order['orderprice'].toStringAsFixed(2))),
                                            Text((' x ')+(widget.order['orderqty'].toString()))
                                          ],
                                          ),
                                        )
                                      ],
                                    )
                                )
                          ],
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const Text('See more...'),
                        Text(widget.order['deliverystatus'])
                      ],),
                      children: [
                        Container(
                          //height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: widget.order['deliverystatus'] == 'delivered'
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(('Name: ')+(widget.order['custname']), style: const TextStyle(fontSize: 15),),
                                Text(('Phone No.: ')+(widget.order['phone']), style: const TextStyle(fontSize: 15),),
                                Text(('Email Address: ')+(widget.order['email']), style: const TextStyle(fontSize: 15),),
                                Text(('Address: ')+(widget.order['address']), style: const TextStyle(fontSize: 15),),
              
                                Row(
                                  children: [
                                    const Text( 'Payment Status: ',style: TextStyle(fontSize: 15)),
                                    Text(widget.order['paymentstatus'], style: const TextStyle(fontSize: 15,color: Colors.purple))
                                  ]
                                ),
                                Row(
                                  children: [
                                    const Text('Delivery Status: ', style: TextStyle(fontSize: 15),),
                                    Text(widget.order['deliverystatus'], style: const TextStyle(fontSize: 15,color: Colors.green),),
                                  ],
                                ),
                                
                                widget.order['deliverystatus'] == 'shipping'
                                  ? Text(('Estimated Delivery Date: ')+(DateFormat('dd-MM-yyyy').format(widget.order['deliverydate'].toDate())).toString(), style: const TextStyle(fontSize: 15, color:Colors.blue),) // updated this model show the date chosen by supplier
                                  : const Text(''),
                                
                                widget.order['deliverystatus'] == 'delivered' && widget.order['orderreview'] == false //delivered but no review
                                  ? TextButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context, 
                                        builder: (context)=> Material(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 250),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: 1,
                                                  minRating: 1,
                                                  allowHalfRating: true,
                                                  itemBuilder: (context, _){
                                                    return const Icon(Icons.star, color: Colors.amber,);
                                                  }, 
                                                    onRatingUpdate: (value){
                                                      rate = value;
                                                    }
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter your Review',
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.grey,width: 1),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(color: Colors.amber,width: 2),
                                                      borderRadius: BorderRadius.circular(15),
                                                    ),
                                                  ),
                                                  onChanged: (value){
                                                    comment = value;
                                                  }
                                                ),
                                                const SizedBox(height: 12,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    const SizedBox(width: 12,),
                                                    YellowButton(label: 'cancel', onPressed: (){
                                                      Navigator.pop(context);
                                                    }, width: 0.3),
                                                    const SizedBox(width: 12,),
                                                    YellowButton(
                                                        label: 'ok', 
                                                        onPressed: () async{

                                                          CollectionReference collRef = FirebaseFirestore.instance.collection('products').doc(widget.order['proid']).collection('reviews') ;

                                                          await collRef.doc(FirebaseAuth.instance.currentUser!.uid).set({
                                                            //* to store all info relevant to a comment/review such as name, profile pic, rating etc..
                                                            'name': widget.order['custname'],
                                                            'email': widget.order['email'],
                                                            'profileimage': widget.order['profileimage'],
                                                            'comment': comment,
                                                            'rate': rate,
                                                          }).whenComplete(() async{ //* set orderreview to true after writing review to prevent rewrites directly from order page
                                                            await FirebaseFirestore.instance.runTransaction(
                                                              (transaction) async{
                                                                DocumentReference documentReference = FirebaseFirestore.instance.collection('orders').doc(widget.order['orderid']);

                                                                transaction.update(documentReference, {'orderreview': true});
                                                            }
                                                            );
                                                          });
                                                          if (!context.mounted) return;
                                                          Navigator.pop(context); //* pop after all running all the processes
                                                      }, width: 0.3),
                                                    const SizedBox(width: 12,),
                                              ],)
                                            ],),
                                          ),
                                      ));
                                    }, 
                                    child: const Text('Write Review'))
                                  : const Text(''),
              
                                widget.order['deliverystatus'] == 'delivered' && widget.order['orderreview'] == true //delivered and reviewed
                                  ? const Row(children: [
                                      Icon(Icons.check, color: Colors.blue),
                                      Text('Review added',style: TextStyle(color: Colors.blue,fontStyle: FontStyle.italic),)                                   
                                    ],)
              
                                  : const Text('')
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  );
  }
}