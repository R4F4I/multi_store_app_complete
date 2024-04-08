import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black,
          ),
          onPressed: () { Navigator.pop(context); },
        ),
        title: const CupertinoSearchTextField()
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
          .collection('products')          
          .snapshots(), builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {           
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Material(child: Center(child: CircularProgressIndicator()));
            }
              return ListView(
              children:
                  snapshot.data!.docs.map((e) => Text(e['proname'])).toList(), //in snapshot each unique record is passed into 'e' via .map where a Text widget with val. 'e[proname]' is returned, these returned text widgets are again turned into a list to be passed into list view
            );
            }),
  );
  }
}