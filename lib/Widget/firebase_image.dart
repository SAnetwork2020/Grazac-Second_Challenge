import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
class PetProfile extends StatefulWidget {
  const PetProfile({Key? key}) : super(key: key);

  @override
  State<PetProfile> createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Profile'),
      ),
      body: Builder(
          builder: (context) =>
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: const Color(0xff476cfb),
                            child: ClipOval(
                              child: (_image!=null)? Image.file(_image!,fit:
                              BoxFit.fill,):
                              SizedBox(
                                width: 180, height: 180, child: Image.asset(
                                'assets/images/cat_breeds/exotic-shorthair.jpg',
                                fit: BoxFit.fill,),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 60), child:
                        IconButton(icon: const Icon(Icons.camera_enhance_rounded,
                          size: 30,),
                          onPressed: (){},),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Column(
                                children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Username', style: TextStyle(color:
                                    Colors.blueGrey, fontSize: 18),),),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        'Michelle James', style: TextStyle
                                      (color:
                                    Colors.black, fontSize: 20, fontWeight:
                                    FontWeight.bold)),),
                                ]
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.centerRight,child:
                        Container(
                          child: const Icon(Icons.edit_rounded, color: Color
                            (0xff476cfb),),
                        ),)
                      ],),
                    ElevatedButton(
                        onPressed: (){
                          selectFile();
                          },
                        child: const Text
                      ('Select File')),
                    ElevatedButton(
                        onPressed: (){
                          uploadPic();
                          },
                        child: const Text
                      ('Upload '
                        'Picture')),
                    SizedBox(height: 32,),
                    if(pickedFile != null)Expanded(
                        child: Container(
                          color: Colors.blue[100],
                          child: Center(
                            child: Image.file(
                              File(pickedFile!.path!),width: double.infinity,
                                fit:BoxFit.cover,
                            ),
                          )
                        )),
                    buildProgress(),
                  ],
                ),
              )
      ),
    );
  }
  // Future getImage() async{
  //   var image = await ImagePicker().pickImage(source:ImageSource.gallery);
  //   setState(() {
  //     _image =image as File?;
  //     print('Image Path $_image');
  //   });
  // }
  // Future uploadPic(BuildContext context)async{
  //   String fileName = basename('${_image!.path}');
  //   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask uploadTask=firebaseStorageRef.putFile(_image!);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>setState(() {
  //     print('Profile Picture uploaded');
  //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picutre Uploaded')));
  //   }));
  //
  //   // FirebaseStorage storage = FirebaseStorage.instance;
  //   // Reference ref = storage.ref().('image/'+DateTime.now().toString());
  //   // UploadTask uploadTask = ref.putFile(File(_image!.path));
  //   // uploadTask.then((res) => res.ref.getDownloadURL());
  // }

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }


  Future uploadPic()async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete((){});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress()=>StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder: (context,snapshot){
      if (snapshot.hasData){
        final data = snapshot.data!;
        double progress = data.bytesTransferred/data.totalBytes;
        return SizedBox(
          height: 50,
            child: Stack(
              fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                      backgroundColor: Colors.grey,
                      color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(100*progress).roundToDouble()}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
            ),
        );
      }else{
        return const SizedBox(height: 50,);
      }
    },
  );
}
