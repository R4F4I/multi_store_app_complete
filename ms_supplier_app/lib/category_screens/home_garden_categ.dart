import 'package:flutter/material.dart';
import 'package:ms_supplier_app/utilities/categ_list.dart';
import 'package:ms_supplier_app/widgets/categ_widgets.dart';



class HomeGardenCategory extends StatelessWidget {
  const HomeGardenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeaderLabel(headerLabel: "Home & Garden",), /*is supposed to be category header label */
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 50,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(homeandgarden.length -1, (index) {
                        return SubCategoryModel(
                          mainCategName: 'homeandgarden',
                          subCategName:homeandgarden[index +1] ,
                          assetName:'images/homegarden/home$index.jpg' ,
                          subCategLabel:homeandgarden[index +1] ,
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
              bottom: 0,
              right: 0,
              child: SliderBar(mainCategName: 'Home & Garden',))
        ],
      ),
    );
  }
}





