import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier_app/minor_screens/edit_store.dart';
import 'package:ms_supplier_app/widgets/appbar_widgets.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/product_model.dart';

class VisitStore extends StatefulWidget {
  final String suppID;
  const VisitStore({super.key, required this.suppID});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  bool following = false;
  @override
  Widget build(BuildContext context) {
    CollectionReference suppliers = FirebaseFirestore.instance.collection('suppliers');
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid',isEqualTo: widget.suppID)
        .snapshots();

    return FutureBuilder<DocumentSnapshot>(
      future: suppliers.doc(widget.suppID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade100,
            appBar: AppBar(
              leading: const YellowBackButton(),
              toolbarHeight: 100,
              flexibleSpace: data['coverimage'] == ''
              ? Image.asset(
                'images/inapp/coverimage.jpg',
                fit: BoxFit.cover,
              )
              : Image.network(
                data['coverimage'],
                fit: BoxFit.cover,
                ),
              title: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4,color: Colors.yellow),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(data['storelogo'],fit:BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 77,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                 data['storename'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                        data['sid']==FirebaseAuth.instance.currentUser!.uid
                            ? Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*0.3,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                      width: 3,
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EditStore(data: data,)));
                                  },
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('Edit'),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.black,)],
                                    )
                                  ),
                                ),
                              )
                            : Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*0.35,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  border: Border.all(
                                      width: 3,
                                      color: Colors.black),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: MaterialButton(
                                  onPressed: (){
                                    setState(() {
                                      following = !following;
                                    });
                                  },
                                  child: Center(
                                    child: following == true
                                        ? const Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.red,size: 20,),
                                            SizedBox(width: 1,),
                                            Text('UNFOLLOW',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        )
                                        : const Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.red,size: 20,),
                                            SizedBox(width: 1,),
                                            Text('FOLLOW',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                ),
                              )
                      ],),
                  )
                ],),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: productsStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.docs.isEmpty){
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
                  }
                  return SingleChildScrollView(
                    child: StaggeredGridView.countBuilder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        crossAxisCount: 2,
                        itemBuilder: (context,index){
                          return ProductModel(products: snapshot.data!.docs[index]);
                        },
                        staggeredTileBuilder: (context)=>const StaggeredTile.fit(1)),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.green,
              child: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 40,
              ),
              onPressed: (){},
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
