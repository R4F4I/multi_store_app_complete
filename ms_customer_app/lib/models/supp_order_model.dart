import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class SupplierOrderModel extends StatelessWidget {
  final dynamic order;
  const SupplierOrderModel({super.key, required this.order});

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
                                      child: Image.network(order['orderimage']),
                                    ),
                                ),
                                Flexible(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text(
                                        order['ordername'],
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
                                            Text(('\$ ')+(order['orderprice'].toStringAsFixed(2))),
                                            Text((' x ')+(order['orderqty'].toString()))
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
                        Text(order['deliverystatus'])
                      ],),
                      children: [
                        Container(
                          //height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: order['deliverystatus'] == 'delivered'
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(('Name: ')+(order['custname']), style: const TextStyle(fontSize: 15),),
                                Text(('Phone No.: ')+(order['phone']), style: const TextStyle(fontSize: 15),),
                                Text(('Email Address: ')+(order['email']), style: const TextStyle(fontSize: 15),),
                                Text(('Address: ')+(order['address']), style: const TextStyle(fontSize: 15),),
              
                                Row(
                                  children: [
                                    const Text( 'Payment Status: ',style: TextStyle(fontSize: 15)),
                                    Text(order['paymentstatus'], style: const TextStyle(fontSize: 15,color: Colors.purple))
                                  ]
                                ),
                                Row(
                                  children: [
                                    const Text('Delivery Status: ', style: TextStyle(fontSize: 15),),
                                    Text(order['deliverystatus'], style: const TextStyle(fontSize: 15,color: Colors.green),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Order Date: ', style: TextStyle(fontSize: 15),),
                                    Text(DateFormat('dd-MM-yyyy').format(order['orderdate'].toDate()).toString(), style: const TextStyle(fontSize: 15,color: Colors.green),),
                                  ],
                                ),
                                order['deliverystatus'] == 'delivered'
                                ? const Text('This order has already been delivered')
                                : Row(
                                    children: [
                                      const Text('Change Delivery Status To: ', style: TextStyle(fontSize: 15),),
                                      order['deliverystatus']=='preparing'
                                      ? TextButton(onPressed: (){
                                        DatePicker.showDatePicker(context,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime.now().add(const Duration(days: 365)),
                                        onConfirm: (date) async{
                                          await FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(order['orderid'])
                                            .update({
                                              'deliverystatus': 'shipping', //* changes delivery status to 'shipping'
                                              'deliverydate': date, // * change deliverydate to the date chosen in datePicker 
                                            });
                                        }
                                        );
                                      }, child: const Text('shipping?'))
                                      : TextButton(onPressed: () async{
                                        
                                          await FirebaseFirestore.instance
                                            .collection('orders')
                                            .doc(order['orderid'])
                                            .update({
                                              'deliverystatus': 'delivered', //* changes delivery status to 'delivered'
                                            });
                                      }, child: const Text('delivered?'))
                                    ],
                                  ),
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