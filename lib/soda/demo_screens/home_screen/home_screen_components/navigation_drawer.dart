import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
   NavigationDrawer({Key? key}) : super(key: key);
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
              const Text('snetwork@gmail.com'),
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
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ), separatorBuilder: (BuildContext context, int index)
            =>const SizedBox(height: 20,),
            ),
          ),
          SizedBox(height: 56, width: double.infinity,
            child: ElevatedButton.icon(
                onPressed: (){},
                label: const Text('Log Out'),
              icon: const Icon(Icons.logout) ,
            ),
          )
        ],
      ),
    );
  }
}
