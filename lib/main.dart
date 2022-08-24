import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:second_challenge/Widget/constant.dart';
import 'package:second_challenge/soda/demo_screens/home_screen/home_screen_components/home_screen.dart';
import 'package:second_challenge/soda/demo_screens/signin_screen.dart';
import 'package:second_challenge/soda/demo_screens/signup_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Widget/auth_screen.dart';

Future main() async{
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: SignUpScreen(),
    );
  }
}


