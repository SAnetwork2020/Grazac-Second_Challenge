import 'package:flutter/material.dart';
import 'package:second_challenge/soda/demo_screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late final User loggedInUser;

  void getCurrentUser()async{
    try{
      final user = _auth.currentUser!;
      loggedInUser = user;
      print(loggedInUser.email);
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vet Veterinary'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu,),
              onPressed: () {Scaffold.of(context).openDrawer();},
            );
          }
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {  },),
          const SizedBox(width: 8,),
          IconButton(icon: const Icon(Icons.shopping_cart_rounded), onPressed: () {  },),
          const SizedBox(width: 20,),
        ],

      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Welcome to Firebase, you have successfully Signed In!!!',
              style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28
            ),),
            SizedBox(width: 150,height: 56,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: (){
                  FirebaseAuth.instance.signOut().then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen()));
                  });
                },
                child: const Center(
                  child: Text('Logout', style: TextStyle(fontSize: 18,color:
                      Colors.white70)
                    ,),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Container(height: 250, width: 400,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    offset: const Offset(-5,-5),
                    blurRadius: 10,
                    spreadRadius: 0
                  ),
                  BoxShadow(
                    color: const Color(0xffAAAACC).withOpacity(.25),
                    offset: const Offset(5,5),
                    blurRadius: 10,
                    spreadRadius: 0
                  ),
                  BoxShadow(
                    color: const Color(0xffAAAACC).withOpacity(.50),
                    offset: const Offset(10,10),
                    blurRadius: 20,
                    spreadRadius: 0
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(1),
                    offset: const Offset(-10,-10),
                    blurRadius: 20,
                    spreadRadius: 0
                  ),
                ],
                color: Colors.white60,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/cat_breeds/abyssinian.jpg',
                    scale: 2,),
                  // SizedBox(width: 16,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,right: 15,),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children:   [
                        const Text('Abyssinian Cat', style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.w700),),
                        const SizedBox(height: 3,),
                        const Text('Age: 24 months', style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w500),),
                        const Text('Gender: Male', style: const TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w500),),
                        const SizedBox(height: 3,),
                        const Text('Taking care of a pet \nis my favorite, it '
                            'helps \nme to...', style: TextStyle(fontSize: 16,
                            fontWeight: FontWeight.w400),),
                        const SizedBox(height: 3,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.location_pin),
                            Text('Lagos',  textAlign:TextAlign.end, style:
                            TextStyle(fontSize:
                            18,
                              fontWeight: FontWeight.w500, color: Colors.red,
                            ),),
                            SizedBox(width: 30,),
                            Text('N25 000',  textAlign:TextAlign.end, style:
                              TextStyle(fontSize:
                            18,
                                fontWeight: FontWeight.w500, color: Colors.green,
                              ),),

                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: NavigationDrawer(),
      // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed
      //     items: [items]),
      bottomNavigationBar: SizedBox(height: 60,
        child: BottomAppBar(
          color: Colors.redAccent,
            notchMargin: 5,
            shape: (),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
            children: [
              // IconButton(onPressed: (){}, icon: Icon(color: Colors.white, Icons
              //     .home_rounded)),
              IconButton(onPressed: (){}, icon: Icon(color: Colors.white, Icons
                  .home_rounded)),
              IconButton(onPressed: (){}, icon: Icon(color: Colors.white, Icons
                  .home_rounded)),
              IconButton(onPressed: (){}, icon: Icon(color: Colors.white, Icons
                  .home_rounded)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},child: Icon(Icons.send),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartDocked,
    );
  }
}

