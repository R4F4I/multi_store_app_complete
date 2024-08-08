import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_supplier_app/minor_screens/product_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String searchInput = '' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade300,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,
          ),
          onPressed: () { Navigator.pop(context); },
        ),
        title: CupertinoSearchTextField(
          backgroundColor: Colors.white,
          autofocus: true, // to auto open keyboard
          onChanged: (value) {
            setState(() {
              searchInput = value;
            });
          },
        )
      ),
      body: searchInput =='' 
      ? Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Text(
                      'Search Anything...',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
      : StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection('products')          
            .snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {           
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Material(child: Center(child: CircularProgressIndicator()));
              }

              final result = snapshot.data!.docs.where((e) => e['proname'].toLowerCase().contains(searchInput.toLowerCase()));

                return ListView(
                children:
                    result.map((e) => SearchModel(e: e)).toList(), //in snapshot each unique record is passed into 'e' via .map where a Text widget with val. 'e[proname]' is returned, these returned text widgets are again turned into a list to be passed into list view
              );
              }),
  );
  }
}

class SearchModel extends StatelessWidget {
  final dynamic e;
  const SearchModel({super.key, required this.e});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(proList: e)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          height: 100,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image(
                    image: NetworkImage(e['proimages'][0]),
                    fit: BoxFit.contain,
                    )
                  ),
                ),
              const SizedBox(width: 10,),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [

                      Text(
                        e['proname'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      Text(
                      e['prodesc'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}