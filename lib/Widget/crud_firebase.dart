import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

class CrudScreen extends StatefulWidget {
  const CrudScreen({Key? key}) : super(key: key);

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final CollectionReference _products = FirebaseFirestore.instance.collection
    ('products');
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  Future<void>_update([DocumentSnapshot? documentSnapshot])async{
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _genderController.text = documentSnapshot['gender'];
      _ageController.text = documentSnapshot['age'].toString();

    }
    await showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
        return Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText('Name',_nameController),
              customNumText('gender',_genderController),
              customText('age',_ageController),
              customNumText('price',_priceController),
                const SizedBox(height: 20,),
              Row(
                children: [

                  ElevatedButton(
                      onPressed: ()async{
                        final String name = _nameController.text;
                        final double? price = double.tryParse(_priceController.text);
                        final String gender = _genderController.text;
                        final double? age = double.tryParse(_ageController.text);

                        await _products
                      .doc(documentSnapshot!.id)
                      .update({'name':name, "price": price, 'age':age, 'gender'
                            :gender});
                        _nameController.text = '';
                        _priceController.text = '';
                        _genderController.text = '';
                        _ageController.text = '';
                      }, child: const Text('Add Photo'),
                  ),
                  ElevatedButton(
                      onPressed: ()async{
                        final String name = _nameController.text;
                        final double? price = double.tryParse(_priceController.text);
                        final String gender = _genderController.text;
                        final double? age = double.tryParse(_ageController.text);

                        await _products
                      .doc(documentSnapshot!.id)
                      .update({'name':name, "price": price, 'age':age, 'gender'
                            :gender});
                        _nameController.text = '';
                        _priceController.text = '';
                        _genderController.text = '';
                        _ageController.text = '';
                      }, child: const Text('Update'),
                  ),
                ],
              )
            ],
        ),
        );
        }
    );
  }
  TextField customText(String text, TextEditingController controller) {
    return TextField(
              controller: controller,
                decoration: InputDecoration(
                  labelText: text,
                ),
            );
  }
  Future<void>_create([DocumentSnapshot? documentSnapshot])async{
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _genderController.text = documentSnapshot['gender'];
      _ageController.text = documentSnapshot['age'].toString();

    }
    await showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
        return Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 20,
        bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image != null? Center(
                      child: Image.file(
                        image!, width: 160,
                      height: 160,fit: BoxFit.cover,)):
                     const Text('No image selected yet'),
                ],
              ),
              customText('Name',_nameController),
              customText('Gender',_genderController),
              customNumText('Age',_ageController),
              customNumText('Price',_priceController),
                const SizedBox(height: 8,),
                // Text('Image file: ${image!.path}'),
                const SizedBox(height: 20,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: ()=>uploadImage(),
                      label:const Text('Create'), icon:
                      const Icon(Icons.upload_rounded),
                  ),
                  ElevatedButton.icon(
                      onPressed: ()=>pickImage(), icon: const Icon(Icons
                      .photo_rounded), label:
                  const Text('Add Photo'),
                  ),
                ],
              ),
            ],
        ),
        );
        }
    );
  }

  TextField customNumText(String text, TextEditingController controller) {
    return TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal:
              true),
              controller: controller,
                decoration:  InputDecoration(
                  labelText: text,
                ),
            );
  }
  Future<void> _delete(String productId)async{
    await _products.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have sucessfully deleted a product')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _create(), child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: buildStreamBuilder(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> buildStreamBuilder() {
    return StreamBuilder(
      stream: _products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)
      {
        if (streamSnapshot.hasData)
        {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context,index){
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['name']),
                  subtitle: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Name: '+ documentSnapshot['name']),
                          Text('Gender: '+ documentSnapshot['gender']),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Age: '+ documentSnapshot['age'].toString()),
                          Text('N'+ documentSnapshot['price'].toString
                            ()),
                        ],
                      ),
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,child: Row(
                    children: [
                      IconButton(onPressed: ()=>_update(documentSnapshot),
                          icon: const Icon(Icons.edit_rounded)),
                      IconButton(onPressed: ()=>_delete(documentSnapshot.id),
                          icon: const Icon(Icons.delete_rounded)),
                    ],
                  ),
                  ),
                ),
              );
              }
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
File? image;
  Future pickImage() async {

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      // final imagePermanent = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print('Unable to pick image: $e');
    }
  }
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  UploadTask? uploadTask;
Future uploadImage() async{
    final path = 'files/${image!.path}';
    final file = File(image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete((){});
    final String urlDownload = await snapshot.ref.getDownloadURL();
    final String name = _nameController.text;
    final double? price = double.tryParse(_priceController.text);
    final String gender = _genderController.text;
    final double? age = double.tryParse(_ageController.text);

    if (price != null ){
      await _products.add({'name':name, "price": price, ''
          'age':age, 'gender':gender, 'image':urlDownload});
      _nameController.text = '';
      _priceController.text = '';
      _genderController.text = '';
      _ageController.text = '';
      Navigator.pop(context);
    }
      print('Download Link: $urlDownload');
    setState(() {
      uploadTask = null;
    });
}
}
