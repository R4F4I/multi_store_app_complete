import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';


class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height*0.45,
          child: Swiper(
            pagination: const SwiperPagination(builder: SwiperPagination.fraction),
            itemBuilder: (context,index){
            return const Image(image: NetworkImage('https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',),);
          }, 
            itemCount: 1,
            ),
          ),
          Text('pro name',
           style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.w600),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          children: [
            const Row(
              children: [
                Text('USD',style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  ),
                ),
                Text(' 99.99',style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: (){}, 
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
                size: 30,
                ),
              ),
            
          ],),
          const Text(' 99 pieces left in stock',
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  ),
                ),
      ],)
    );
  }
}