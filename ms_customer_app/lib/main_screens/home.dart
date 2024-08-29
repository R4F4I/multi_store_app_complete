import 'package:flutter/material.dart';
import 'package:ms_customer_app/galleries/accessories_gallery.dart';
import 'package:ms_customer_app/galleries/bags_gallery.dart';
import 'package:ms_customer_app/galleries/beauty_gallery.dart';
import 'package:ms_customer_app/galleries/electronics_gallery.dart';
import 'package:ms_customer_app/galleries/homeandgarden_gallery.dart';
import 'package:ms_customer_app/galleries/kids_gallery.dart';
import 'package:ms_customer_app/galleries/men_gallery.dart';
import 'package:ms_customer_app/galleries/shoes_gallery.dart';
import 'package:ms_customer_app/galleries/women_gallery.dart';
import 'package:ms_customer_app/widgets/fake_search.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar:  AppBar(
    
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),

          bottom: const TabBar(
            isScrollable: true,
            indicatorColor:  Colors.amberAccent,
            indicatorWeight: 8,
            tabs: [
            /*each tab is converted into a function to be called*/ 
            RepeatedTab(label: 'Men',),
            RepeatedTab(label: 'Women',),
            RepeatedTab(label: 'shoes',),
            RepeatedTab(label: 'Bags',),
            RepeatedTab(label: 'electronics',),
            RepeatedTab(label: 'Accessories',),
            RepeatedTab(label: 'Home & Garden',),
            RepeatedTab(label: 'Kids',),
            RepeatedTab(label: 'Beauty',),
              ]),
              
          ),

        body: const TabBarView(children: [
          MenGalleryScreen(),
          WomenGalleryScreen(),
          ShoesGalleryScreen(),
          BagsGalleryScreen(),
          ElectronicsGalleryScreen(),          
          AccessoriesGalleryScreen(),          
          HomeAndGardenGalleryScreen(),          
          KidsGalleryScreen(),
          BeautyGalleryScreen(),
          /*for content within the tabs */
        ],),
      ),
    );
  }
}


/*each tab here, converted into function which accepts a string as a parameter and returns
it as a tab */
class RepeatedTab extends StatelessWidget {
  final String  label; /* here it takes label as parameter */
  const RepeatedTab({
    super.key, required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(label,style: const TextStyle(
      color: Colors.grey),),);
  }
}
