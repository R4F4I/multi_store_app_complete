import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/add_address.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';
import 'package:multi_store_app/widgets/yellow_button.dart';


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
                return GestureDetector(
                  onTap: () async{
                    // in a 'for loop', set all the 'default'  categories to false,
                    for (var item in snapshot.data!.docs ){
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.yellow.shade100,
                      child: ListTile(
                        trailing: customer['default'] == true 
                          ? const Icon(Icons.home, color: Color.fromARGB(106, 0, 0, 0),)
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