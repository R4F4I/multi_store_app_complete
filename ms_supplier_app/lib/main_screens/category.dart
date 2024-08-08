import 'package:flutter/material.dart';
import 'package:ms_supplier_app/category_screens/accessories_categ.dart';
import 'package:ms_supplier_app/category_screens/bags_categ.dart';
import 'package:ms_supplier_app/category_screens/beauty_categ.dart';
import 'package:ms_supplier_app/category_screens/electronics_categ.dart';
import 'package:ms_supplier_app/category_screens/home_garden_categ.dart';
import 'package:ms_supplier_app/category_screens/kids_categ.dart';
import 'package:ms_supplier_app/category_screens/men_categ.dart';
import 'package:ms_supplier_app/category_screens/shoes_categ.dart';
import 'package:ms_supplier_app/category_screens/women_categ.dart';
import 'package:ms_supplier_app/widgets/fake_search.dart';

List<ItemsData> items = [
  ItemsData(label: 'Men'),
  ItemsData(label: 'women'),
  ItemsData(label: 'shoes'),
  ItemsData(label: 'bags'),
  ItemsData(label: 'electronics'),
  ItemsData(label: 'accessories'),
  ItemsData(label: 'home & garden'),
  ItemsData(label: 'Kids'),
  ItemsData(label: 'Beauty'),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

@override
  void initState() {
    for (var element in items) {
            element.isSelected = false;
          }

          setState(() {
            items[0].isSelected = true;
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch()),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
          Positioned(bottom: 0, right: 0, child: categView(size)),
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8, //725,
      //we are doing a const in height above to fit for android emulator

      /*size is const, for ratio: replace 800 with 'size.width * 0.8'*/
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
                /*
                for (var element in items){
                  element.isSelected = false;
                }
                */

                /*
                the for loop initialises the val:'isSelected' of all elements
                 in 'items' to false each time this part of code is run 
                */

                /*
                in the for loop the list is 'items' its length defines range, 
                and 'element' defines current value in index 
                */
                /*
                setState(() {
                  items[index].isSelected = true;
                });
                */
              },
              child: Container(
                color: items[index].isSelected == true
                    ? Colors.white
                    : Colors.grey.shade300,
                height: 100,
                child: Center(
                  child: Text(items[index].label),
                ),
              ),
            );
          }),
    );
  }

  Widget categView(Size size) {
    return Container(
      height: size.height * 0.8,//size.width * 1.0, 
      //we are doing a const in height above to fit for android emulator
      /*size is const, for ratio: replace 800 with 'size.width * 0.8'*/
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }

          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WomenCategory(),
          ShoesCategory(),
          BagsCategory(),
          ElectronicsCategory(),
          AccessoriesCategory(),
          HomeGardenCategory(),
          KidsCategory(),
          BeautyCategory(),
        ],
      ),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;
  ItemsData({required this.label, this.isSelected = false});
}
/*
> class is 'Itemsdata',
> 'items' is object
> declaration of 'label' & 'isSelected',  
> constructor syntax is starting with class name, 
'reqiuring' input of self 'label' (this.label),
initialising val of self isSelected to false,
 */
