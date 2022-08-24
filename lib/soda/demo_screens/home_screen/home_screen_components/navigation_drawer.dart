import 'package:flutter/material.dart';
import 'package:second_challenge/soda/demo_screens/sign_in/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatelessWidget {
   NavigationDrawer({Key? key, required this.username}) : super(key: key);
   final String username;
  final List<Map<dynamic,dynamic>> myDrawer =[
    {
      'leading': Icons.home_rounded,
      'title':'Home'
    },
    {
      'leading': Icons.category_rounded,
      'title':'Category'
    },
     {
      'leading': Icons.shopping_cart_rounded,
      'title':'Cart'
    },
    {
      'leading': Icons.settings_rounded,
      'title':'Settings'
    },
    {
      'leading': Icons.help_rounded,
      'title':'About'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 150,),
          Column(
            children: [
              CircleAvatar(
                radius: 70,
                child: Image.asset('assets/images/girl_5516806-removebg-preview.png'),
              ),
              const SizedBox(height: 16,),
              const Text('Welcome: Roboto Olawale'),
              Text('$username'),
            ],
          ),
          const SizedBox(height: 16,),
          Expanded(
            child: ListView.separated(
              itemCount: myDrawer.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index)=>
              InkWell(
                onTap: (){},
                child: ListTile(
                  tileColor: Colors.transparent,
                    leading: Icon(myDrawer[index]['leading']),
                  title: Text('${myDrawer[index]['title']}'),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ), separatorBuilder: (BuildContext context, int index)
            =>const SizedBox(height: 20,),
            ),
          ),
          SizedBox(height: 56, width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: ()async{
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', false);
                  Navigator.pushReplacement(context, MaterialPageRoute
                    (builder: (context)=>const SignInScreen()));
                },
                label: const Text('Log Out'),
              icon: const Icon(Icons.logout) ,
            ),
          )
        ],
      ),
    );
  }
}
