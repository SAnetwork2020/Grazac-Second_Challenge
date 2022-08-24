

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class DataView extends StatefulWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  State<DataView> createState() => _productsViewState();
}

class _productsViewState extends State<DataView> {
  final CollectionReference _products = FirebaseFirestore.instance.collection
    ('Soft-Skills');
  final controller = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _ageController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _genderController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(controller: controller,),
          actions: [IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // final name = controller.text;
              // createUser(name:name);
            },
          )
          ],
        ),
        body: StreamBuilder(
            stream: _products.snapshots(),
            builder: (context, AsyncSnapshot<dynamic> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['name']),
                          subtitle: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(documentSnapshot['age'].toString()),
                                  Text(documentSnapshot['gender']),
                                  // Text(documentSnapshot['price'].toString()),
                                ],
                              ),
                              const SizedBox(height: 24,),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(documentSnapshot['price'].toString()),
                                  const Text('Location: Kwara State'),
                                  // Text(documentSnapshot['price'].toString()),
                                ],
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 100,
                              child:Row(children: [
                                IconButton(
                                    onPressed: (){_update(documentSnapshot);},
                                    icon:const Icon(Icons
                                    .edit_rounded)
                                )
                              ],

                              ),
                          )
                        ),
                      );
                    }
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );

  }
  Future _update([DocumentSnapshot? documentSnapshot])async{
    if (documentSnapshot != null){
      _ageController.text = documentSnapshot['age'];
      _genderController.text = documentSnapshot['gender'];
      _priceController.text = documentSnapshot['price'];
      _nameController.text = documentSnapshot['name'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        // isDismissible: true,
        context: context, builder: (BuildContext ctx){
      return Padding(padding: EdgeInsets.only(
          top: 20, left: 20, right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name of the Pet'),
            ),
            TextField(
              controller: _genderController,
              decoration: const InputDecoration(labelText: 'Gender of the Pet'),
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price of the Pet'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age of the Pet'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: ()async{
                final String name = _nameController.text;
                final String gender = _genderController.text;
                final double? price = double.tryParse(_priceController.text);
                final double? age = double.tryParse(_priceController.text);
                if (price != null){
                  await _products.doc(documentSnapshot!.id)
                      .update({'name':name,'price':price, 'age':age, 'gender':gender});
                  _nameController.text= '';
                  _priceController.text = '';
                  _ageController.text = '';
                  _genderController.text = '';
                }
              }, child: const Text('Update'),
            )
          ],
        ),
      );
    }
    );
  }

Future createUser({required String name}) async{
  final docUser = FirebaseFirestore.instance.collection('users').doc
    ();
  // final json = {
  // 'name':name,
  //   'age': 21,
  //   'birthday': DateTime(2001,7,28),
  // };
  // await docUser.set(json,SetOptions(merge:true));

  final user = User(
    id: docUser.id,
    name: name,
    age: 21,
    birthday: DateTime(2001,7,28),
  );
  final json = user.toJson();
  await docUser.set(json);
  }
}
class User{
String id;
final String? name;
final int? age;
final DateTime? birthday;
User({this.id = '',this.name, this.age, this.birthday,});

Map<String, dynamic> toJson()=>{
  'id': id,
  'name': name,
  'age': age,
  'birthday':birthday,
};
}
