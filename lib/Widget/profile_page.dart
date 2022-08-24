import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  Future pickImage(imageSource) async{
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future saveImagePermanently(String imagePath)async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade300,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
          const Spacer(),
          image != null
              ? ClipOval(
                child: Image.file(image!, width: 160,height: 160,fit:
                  BoxFit.cover,))
              :const FlutterLogo(size:160,),
          const SizedBox(height: 24,),
          const Text('Image Picker', style: TextStyle(
            fontSize: 48, fontWeight: FontWeight.bold,
          ),),
          buildButton(
            title: 'Pick Gallery',
            icon: Icons.image_outlined,
            onClicked: ()=> pickImage(ImageSource.gallery)
          ),
          const SizedBox(height: 24,),
          buildButton(title: 'Pick Camera', icon: Icons.camera_alt_outlined,
              onClicked: ()=>pickImage(ImageSource.camera)),
          const Spacer(),
        ],
        ),
      ),
    );
  }

  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked})=>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          primary: Colors.white,
          onPrimary: Colors.black,
          textStyle: const TextStyle(fontSize: 20),
        ),
          onPressed: onClicked,
          child: Row(children: [
            Icon(icon, size: 28,),
            const SizedBox(width: 16,),
            Text(title),
          ],),
      );


}
