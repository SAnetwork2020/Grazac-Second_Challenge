import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as Path;

import '../../../../Widget/crud_firebase.dart';
import '../../../../Widget/firebase_image.dart';
import 'navigation_drawer.dart';
import 'other_widget.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _petName = TextEditingController();
  final TextEditingController _petAge = TextEditingController();
  final TextEditingController _petPrice = TextEditingController();
  final TextEditingController _petGender = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final CollectionReference _products = FirebaseFirestore.instance.collection
    ('products');
  late final loggedInUser;
bool isLoading = true;
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
        // // title: const Text('Vet Veterinary'),
        // centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu,),
              onPressed: () {Scaffold.of(context).openDrawer();},
            );
          }
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons
              .notifications_none_rounded))
        ],

      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(backgroundImage: AssetImage('assets/images/dog_breeds/beagle.jpg'),
                      ),
                      const SizedBox(width: 20,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Welcome back,', style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '\n${loggedInUser.email}')
                                ]
                              )),
                          Row(
                            children: const [
                              Icon(Icons.location_pin),
                              Text('Lagos'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ]
              ),
              const SizedBox(height: 16,),
              petBuild(),
            ]),
        ),
      ),
      drawer: NavigationDrawer(username: '${loggedInUser.email}',),
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_create(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
  SizedBox bottomNavigationBar() {
    return SizedBox(height: 60,
      child: BottomAppBar(
        color: Colors.red,
        // Colors.redAccent,
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(onPressed: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPet()));
            }, icon: const Icon(color: Colors.white, Icons
                .home_rounded)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)
              =>const PetProfile()));}, icon: const Icon(color: Colors.white,
                Icons.category_rounded)),
            IconButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)
            =>const CrudScreen()));}, icon: const Icon(color: Colors
                .white, Icons
                .shopping_cart_rounded)),
          ],
        ),
      ),
    );
  }


  // CRUD OPERATIONS BELOW:-
  Future<void>_create([DocumentSnapshot? documentSnapshot])async{
    if (documentSnapshot != null) {
      _petName.text = documentSnapshot['name'];
      _petPrice.text = documentSnapshot['price'].toString();
      _petGender.text = documentSnapshot['gender'];
      _petAge.text = documentSnapshot['age'].toString();

    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return isLoading?
          Padding(padding: EdgeInsets.only(top: 20,left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pickedFile != null? Center(
                        child: Image.file(File(pickedFile!.path!), width: 160,
                          height: 160,fit: BoxFit.cover,)):
                    const Text('No image selected yet'),
                  ],
                ),
                customText('Name',_petName),
                customText('Gender',_petGender),
                customNumText('Age(Months)',_petAge),
                customNumText('Price(N)',_petPrice),
                const SizedBox(height: 8,),
                // Text('Image file: ${image!.path}'),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: ()async{
                        final String name = _petName.text;
                        final String gender = _petGender.text;
                        final int age = int.parse(_petAge.text);
                        final price = (_petPrice.text);

                        if (price!= null){
                          await _products.add({'name':name,'price':price,'age'
                              '':age,'gender':gender,'image': imageUrl
                          });
                          _petAge.text = '';
                          _petName.text = '';
                          _petGender.text = '';
                          _petPrice.text = '';
                          Navigator.pop(context);
                        }
                      },
                      label:const Text('Create'), icon:
                    const Icon(Icons.upload_rounded),
                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        addPhoto();
                      }, icon: const Icon(Icons
                        .photo_rounded), label:
                    const Text('Add Photo'),
                    ),
                  ],
                ),
              ],
            ),
          ): const CircularProgressIndicator();
        }
    );
  }
  Future<void>_update([DocumentSnapshot? documentSnapshot])async{
    if (documentSnapshot != null) {
      _petName.text = documentSnapshot['name'];
      _petPrice.text = documentSnapshot['price'].toString();
      _petGender.text = documentSnapshot['gender'];
      _petAge.text = documentSnapshot['age'].toString();

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
                customText('Name',_petName),
                customNumText('Age(Months)',_petAge),
                customText('Gender',_petGender),
                customNumText('Price N',_petPrice),
                const SizedBox(height: 20,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: ()async{
                          final String name = _petName.text;
                          final String gender = _petGender.text;
                          final int age = int.parse(_petAge.text);
                          final int price = int.parse(_petAge.text);
                          if (price!= null) {
                            await _products.doc(documentSnapshot!.id)
                                .update({'name': name, 'price':
                            price, 'age'
                                '': age, 'gender': gender, 'image': imageUrl
                            });
                            _petAge.text = '';
                            _petName.text = '';
                            _petGender.text = '';
                            _petPrice.text = '';
                          }
                          },
                      label:const Text('Update'), icon:
                      const Icon(Icons.upload_rounded),
                    ),
                    ElevatedButton.icon(
                      onPressed: (){
                        addPhoto();
                      }, icon: const Icon(Icons
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
  //This is the Read and Display Operation below this comment
  StreamBuilder<QuerySnapshot<Object?>> petBuild() {
    return StreamBuilder(
      stream: _products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot>streamSnapshot){
        if
        (streamSnapshot.hasData)
        {
          return Expanded(
            child: ListView.separated(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot
                    .data!.docs[index];
                return Slidable(
                  groupTag: 0,
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                      motion: const ScrollMotion() ,
                      children: [
                        SlidableAction(
                          autoClose: true,
                          onPressed: (_){_update(documentSnapshot);},
                          icon: Icons.edit_rounded,
                          label: 'Edit',
                        ),
                      ]
                  ),
                  endActionPane: ActionPane(
                      motion: const ScrollMotion(), children: [
                    SlidableAction(
                      autoClose: true,
                      onPressed: (_){
                        _delete(documentSnapshot.id);
                      },icon: Icons.delete_rounded,
                      backgroundColor: Colors.red,
                      label: 'Delete',
                    )
                  ]),
                  child: Center(
                    child: Container(height: 300, width: double.infinity,
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
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,
                            vertical:
                        10),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Image.network(documentSnapshot['image'].toString(),
                                scale: 2, fit: BoxFit.fill,),
                            ),
                            const SizedBox(width: 8,),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Name: ${documentSnapshot['name']}', style:
                                const TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold, color:Colors
                                        .white),),
                                Text('Age: ${documentSnapshot['age'].toString()
                                } months', style:
                                const TextStyle(fontSize: 18,
                                    fontWeight: FontWeight.bold, color:Colors
                                        .white),),
                                Text('Price: N${documentSnapshot['price']
                                    .toString()}',
                                  style:
                                  const TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.bold, color:Colors
                                          .white),),
                                Text('Gender: ${documentSnapshot['gender']}',
                                  style:
                                  const TextStyle(fontSize: 18,
                                      fontWeight: FontWeight.bold, color:Colors
                                          .white),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index)
            =>const SizedBox(height: 16),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            value: null, strokeWidth: 2.0,
          ),
        );
      },
    );
  }
  Future<void> _delete(String productId)async{
    await _products.doc(productId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have sucessfully deleted a product')));
  }
  // END OF CRUDE OPERATIONS



//Upload Image Function here:-
  PlatformFile? pickedFile;
  Future addPhoto() async{
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    setState(() {
      pickedFile = result.files.single;
    });

      final path = 'Files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      setState(() {
        uploadTask = ref.putFile(file);
      });

      final snapshot = await uploadTask!.whenComplete((){
      });

      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download link: $urlDownload');

      setState(() {
        uploadTask = null;
        bool isLoading = false;
        this.imageUrl = urlDownload;
        Navigator.pop(context);
      });
    }

  UploadTask? uploadTask;
  late String imageUrl;
  // Future uploadPic()async {
  //   final path = 'Files/${pickedFile!.name}';
  //   final file = File(pickedFile!.path!);
  //
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   setState(() {
  //     uploadTask = ref.putFile(file);
  //   });
  //
  //   final snapshot = await uploadTask!.whenComplete((){
  //   });
  //
  //   final urlDownload = await snapshot.ref.getDownloadURL();
  //   print('Download link: $urlDownload');
  //
  //   setState(() {
  //     uploadTask = null;
  //     bool isLoading = false;
  //     this.imageUrl = urlDownload;
  //     Navigator.pop(context);
  //   });
  // }
}
