import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier_app/customer_screens/add_address.dart';
import 'package:ms_supplier_app/widgets/appbar_widgets.dart';
import 'package:ms_supplier_app/widgets/yellow_button.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
      .collection('customers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('address')
      .snapshots();

      Future defAddressSet(dynamic item, dynamic customer) async{
        await FirebaseFirestore.instance.runTransaction((transaction) async{
                        DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('customers')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('address')
                                    .doc(item.id);
                                    
                        // if the item.id matches the 'addressid' field in customer set 'default': true
                        item.id == customer['addressid']
                          ? transaction.update(documentReference, {'default': true})
                          : transaction.update(documentReference, {'default': false});
                      });
      }

      Future updateProfile(dynamic customer) async{
        await FirebaseFirestore.instance.runTransaction((transaction) async{
                        DocumentReference documentReference =
                                FirebaseFirestore.instance
                                    .collection('customers')
                                    .doc(FirebaseAuth.instance.currentUser!.uid);

                        transaction.update(documentReference, {
                            'address': '${customer['city']} - ${customer['state']} - ${customer['country']}',
                            'phone': customer['phone'],
                          });
                      });
        

      }

      void showProgress(){
          ProgressDialog progress = ProgressDialog(context: context);
          progress.show(max: 100,msg:'Please Wait...',progressBgColor: Colors.red);
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle(title: 'Address Book'),),
      body: SafeArea(
          child: Column(
        children: [Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: addressStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Material(child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.data!.docs.isEmpty){ //when a section, filtered with '.where(,isEqualTo: )' returns an empty output
                return const Center(child: Text(
                  'You haven\'t added any addresses yet!',
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
              return ListView.builder(
                itemCount: snapshot.data!.docs.length ,
                itemBuilder: (context,index){
                  var customer = snapshot.data!.docs[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction)async => 
                  await FirebaseFirestore.instance.runTransaction((transaction) async{
                        DocumentReference docReference =
                                FirebaseFirestore.instance
                                    .collection('customers')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('address')
                                    .doc(customer['addressid']);
                        transaction.delete(docReference);
                  }),
                  child: GestureDetector(
                    onTap: () async{
                      // in a 'for loop', set all the 'default'  categories to false,
                      showProgress();
                      for (var item in snapshot.data!.docs ){                      
                        await defAddressSet(item, customer);
                      }
                      await updateProfile(customer);
                      Future.delayed(const Duration(microseconds: 1000)).whenComplete(()=>Navigator.pop(context));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: customer['default'] == true
                                ? Colors.yellow.shade100
                                : Colors.grey.shade500,
                        child: ListTile(
                          trailing: customer['default'] == true 
                            ? const Icon(Icons.home, color: Color.fromARGB(131, 63, 30, 0),)
                            : const SizedBox(),
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
                            ),
                          ),
                        ),
                  ),
                );
                  });
                },
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: YellowButton(
                label: 'Add New Address', 
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddAddress()));}, 
                width: 0.7),
          )
        ],
      )),
    );
  }
}