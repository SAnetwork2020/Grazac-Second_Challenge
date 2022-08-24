import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:second_challenge/soda/demo_screens/home_screen/home_screen_components/home_screen.dart';
import 'package:second_challenge/soda/demo_screens/sign_in/signin_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async{
 WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
  FlutterNativeSplash.remove();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHome}) : super(key: key);
final bool showHome;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.red,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white54,
          filled: true,
        )
      ),
      // home: HomeScreen(),
      home: showHome? const HomeScreen():const SignInScreen(),
    );
  }
}


