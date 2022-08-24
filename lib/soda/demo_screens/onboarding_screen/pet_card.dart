// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class PetCardInfo extends StatefulWidget {
//   const PetCardInfo({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PetCardInfo> createState() => _PetCardInfoState();
// }
//
// class _PetCardInfoState extends State<PetCardInfo> {
//   @override
//   Widget build(BuildContext context) {Container();
//     // return StreamBuilder<Object>(
//     //   stream: _products.snapshots(),
//     //   builder: (context, AsyncSnapshot<QuerySnapshot>streamSnapshot) {
//     //     if (streamSnapshot.hasData){
//     //     return ListView.builder(
//     //       itemCount: streamSnapshot.data!.docs.length,
//     //       itemBuilder: (context,index){
//     //         final DocumentSnapshot documentSnapshot = streamSnapshot.data!
//     //             .docs[index];
//     //       } return Column(
//     //       crossAxisAlignment: CrossAxisAlignment.start,
//     //         children:   [
//     //           const Text('Abyssinian Cat', style: TextStyle(fontSize: 25,
//     //               fontWeight: FontWeight.w700),),
//     //           const SizedBox(height: 3,),
//     //           const Text('Age: 24 months', style: TextStyle(fontSize: 18,
//     //               fontWeight: FontWeight.w500),),
//     //           const Text('Gender: Male', style: const TextStyle(fontSize: 18,
//     //               fontWeight: FontWeight.w500),),
//     //           const SizedBox(height: 3,),
//     //           const Text('Taking care of a pet \nis my favorite, it '
//     //               'helps \nme to...', style: TextStyle(fontSize: 16,
//     //               fontWeight: FontWeight.w400),),
//     //           const SizedBox(height: 3,),
//     //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             children: const [
//     //               Icon(Icons.location_pin),
//     //               Text('Lagos',  textAlign:TextAlign.end, style:
//     //               TextStyle(fontSize:
//     //               18,
//     //                 fontWeight: FontWeight.w500, color: Colors.red,
//     //               ),),
//     //               SizedBox(width: 30,),
//     //               Text('N25 000',  textAlign:TextAlign.end, style:
//     //               TextStyle(fontSize:
//     //               18,
//     //                 fontWeight: FontWeight.w500, color: Colors.green,
//     //               ),),
//     //             ],
//     //           ),
//     //         ],
//     //       ),
//     //     );}
//     //     return const Center(
//     //       child: CircularProgressIndicator(),
//     //     );
//     //   }
//     // );
//   }
// }