import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screens/customer_orders.dart';
import 'package:multi_store_app/customer_screens/wishlist.dart';
import 'package:multi_store_app/main_screens/cart.dart';
import 'package:multi_store_app/widgets/alert_dialog.dart';
import 'package:multi_store_app/widgets/appbar_widgets.dart';


class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({super.key, required this.documentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous = FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return 
    
    FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
        ? anonymous.doc(widget.documentId).get()
        : customers.doc(widget.documentId).get(),
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
                        data['profileimage'] == ''
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
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.90,
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
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartScreen(back: AppBarBackButton(),)));
                          },
                           child:  SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.2,
                             child: const Center(
                               child: Text(
                                'cart', 
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 23),
                                    ),
                             ),
                           ))
                      ),
                    
                      Container(
                          color: Colors.yellow,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerOrders()));
                          },
                           child:  SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.2,
                             child: const Center(
                               child: Text(
                                'Orders', 
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 23),
                                    ),
                             ),
                           ))
                      ),
                    
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),)),
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
                          },
                           child:  SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.2,
                             child: const Center(
                               child: Text(
                                'wishlist', 
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 23),
                                    ),
                             ),
                           ))
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
                            RepeatedListTIle(title: 'Location',
                              subtitle: data['address'] == ''
                              ?'New Jersey - USA'
                              :data['address'],
                              icon: Icons.location_pin,),
                          
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
                          
                           RepeatedListTIle(title: 'Edit Profile',icon: Icons.edit,onPressed:() {} ,),
                           const YellowDivider(),
                           RepeatedListTIle(title: 'Change Password',icon: Icons.lock,onPressed:() {} ,),
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
    /*required*/ this.onPressed, 
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
