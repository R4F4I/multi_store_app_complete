import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ms_customer_app/customer_screens/address_book.dart';
import 'package:ms_customer_app/customer_screens/customer_orders.dart';
import 'package:ms_customer_app/customer_screens/wishlist.dart';
import 'package:ms_customer_app/main_screens/cart.dart';
import 'package:ms_customer_app/minor_screens/change_password.dart';
import 'package:ms_customer_app/providers/cart_provider.dart';
import 'package:ms_customer_app/providers/wish_provider.dart';
import 'package:ms_customer_app/widgets/alert_dialog.dart';
import 'package:ms_customer_app/widgets/appbar_widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String documentId;
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous = FirebaseFirestore.instance.collection('anonymous');
  
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user){
      if (user != null){
        print(user.uid);
        setState(() {
          documentId=user.uid;
        });
      } //TODO: Work on the user == null case
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
        ? anonymous.doc(documentId).get()
        : customers.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {return const Text("Something went wrong");}
        if (snapshot.hasData && !snapshot.data!.exists) {return const Text("Document does not exist");}

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return
            /*Text("Full Name: ${data['full_name']} ${data['last_name']}");*/
             Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.yellow,Colors.brown]
                         )
                        ),),
          CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              expandedHeight: 140,
              flexibleSpace: LayoutBuilder(builder: (context, constraints){
                return FlexibleSpaceBar(
                  title: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: constraints.biggest.height<=120
                    ?1
                    :0,
                    child: const Text("Account",style: TextStyle(color: Colors.black),),
                    ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.yellow,Colors.brown]
                         )
                        ),
                    child: Padding(
                      padding: const EdgeInsets.only(top:25 ,left: 30),
                      child: Row(children: [
                        data['profileimage'] == '' || data['profileimage'] == null
                        ? const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/inapp/guest.jpg'),
                          )

                        : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(data['profileimage']),
                          ),
                       
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            data['name']==""
                              ?'guest'.toUpperCase()
                              :data['name'].toUpperCase(),
                            style: const TextStyle(fontSize: 24, 
                                             fontWeight: FontWeight.w600),),
                        )
                        
                        ],),
                    ),
                      ),  
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Column(children: [
                Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width*0.98,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),)),
                        child: SizedBox(
                              height: 55,
                              width: MediaQuery.of(context).size.width*0.25,
                              child: Center(
                                child: IconButton(icon: badges.Badge(
                                      showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                                      badgeStyle: const badges.BadgeStyle(
                                        badgeColor: Colors.black,
                                      ),
                                      badgeContent:Text(context.watch<Cart>().getItems.length.toString(),style: const TextStyle(color: Colors.white),),
                                      child: const Text(
                                            'Cart', 
                                              style: TextStyle(
                                                color: Colors.yellow,
                                                fontSize: 23),
                                                )),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartScreen(back: AppBarBackButton(),)));},),
                              ),
                            ),
                      ),
                    
                       Container(
                          color: Colors.yellow,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerOrders()));
                          },
                           child:  SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width*0.25,
                             child: const Center(
                               child: Text(
                                       'Orders', 
                                         style: TextStyle(
                                           color: Colors.black54,
                                           fontSize: 23),
                                           ))
                             ,
                           ))
                      ),
                    
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),)),
                        child: SizedBox(
                            height: 55,
                            width: MediaQuery.of(context).size.width*0.25,
                             child: IconButton(icon: badges.Badge(
                                showBadge: context.read<Wish>().getWishItems.isEmpty ? false : true,
                                badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Colors.black,
                                ),
                                badgeContent:Text(context.watch<Wish>().getWishItems.length.toString(),style: const TextStyle(color: Colors.white),),
                                child: const Text(
                                      'Wishlist', 
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 21),
                                          )),onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));},)
                           )
                      ),
                    ],),
                    ),
                Container(
                  color: Colors.grey.shade300,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 150,
                          child: Image(image: AssetImage('images/inapp/logo.jpg')),  
                      ),
                    
                    const ProfileHeaderLabel(headerLabel: ' Account Info. ',),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                          child:  Column(children: [
                            
                            RepeatedListTIle(title: 'Email Address ',
                              subtitle: data['email'] == ''
                                ?'example@example.com' 
                                :data['email'],

                              icon: Icons.email,),

                              
                            const YellowDivider(),
                            RepeatedListTIle(title: 'Phone No. ',
                              subtitle: data['phone'] == ''
                              ?'example:+111111'
                              :data['phone'],
                              
                              icon: Icons.phone,),
                            
                            const YellowDivider(),
                            RepeatedListTIle(
                              title: 'Location',
                              subtitle: userAddress(data),
                              icon: Icons.location_pin,
                              onPressed: FirebaseAuth.instance.currentUser!.isAnonymous?null: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddressBook()));
                              },
                            ),
                          
                        ]
                      ),
                    ),
                  ),
                    const ProfileHeaderLabel(headerLabel: ' Account Settings. ',),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                          child:  Column(children: [
                          
                            RepeatedListTIle(
                                        title: 'Edit Profile',
                                        icon: Icons.edit,
                                        onPressed: () {},
                                      ),
                            const YellowDivider(),
                            RepeatedListTIle(
                                        title: 'Change Password',
                                        icon: Icons.lock,
                                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));},
                                      ),
                            const YellowDivider(),
                            RepeatedListTIle(title: 'Log Out',icon: Icons.logout,

                              onPressed:() async{

                                MyAlertDialog.showMyDialog(
                                  context: context,
                                  title:'Logging Out',
                                  content: 'Are you sure you want to logout?',
                                  tapNo: () {Navigator.pop(context);},
                                  tapYes: () async {
                                          await FirebaseAuth.instance.signOut();
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(context, '/welcome_screen');
                                              },); 
                                },
                            ),
                          ]
                        ),
                      ),
                     ),        
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
       ),
      ],
    ),
  );
}

  return const Center(child: CircularProgressIndicator());
      },
    );
  }
 String userAddress(dynamic data){
  if(FirebaseAuth.instance.currentUser!.isAnonymous){
    return 'example: New Jersey - USA';
  } else if (FirebaseAuth.instance.currentUser!.isAnonymous == false && data['address']==''){
    return 'set your Address';

  }
  return data['address'];

 } 
}




class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,),
    );
  }
}

class RepeatedListTIle extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onPressed;
  final IconData icon;
  
  const RepeatedListTIle({
    super.key, 
    required this.icon,
    this.onPressed, 
    required this.title, 
    this.subtitle='',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title), 
        subtitle: Text(subtitle,style: const TextStyle(color: Colors.grey),),
        leading: Icon(icon),
        ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({
    super.key, required this.headerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const SizedBox(height: 40,width: 50,child: Divider(color: Colors.grey,thickness: 1,)),
      Text(headerLabel, style: const TextStyle(color: Colors.grey,fontSize: 24,fontWeight: FontWeight.bold),),
      const SizedBox(height: 40,width: 50,child: Divider(color: Colors.grey,thickness: 1,)),
    ]),
    );
  }
}
