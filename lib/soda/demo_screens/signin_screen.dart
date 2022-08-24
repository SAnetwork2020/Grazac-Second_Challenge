// import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:second_challenge/soda/demo_screens/reusable_widget.dart';
import 'package:second_challenge/soda/demo_screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'home_screen/home_screen_components/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin{
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  late AnimationController controller;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration
      (seconds: 1));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffCB2B93),
                Color(0xff9546C4),
                Color(0xff5E61F4),
              ], begin:Alignment.topCenter ,end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height * 0.2,
                20,
                0,),
              child: Column(
                children: [
                   Center(child:
                      // Image.asset('assets/images/5516806-removebg-preview.png',
                      //   scale: controller.value,)
                  AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget? child) => Transform.scale(
                        scale: controller.value,
                        child: logoWidget(imageName: 'assets/images/5516806-removebg-preview.png',),
                      ),
                      )
                  ),
                  const SizedBox(height: 30,),
                  reusableTextFormField('Email', Icons.person, false,
                      _emailTextController
                  ),
                  const SizedBox(height: 20,),
                  reusableTextFormField('Password', Icons
                      .lock, true, _passwordTextController),
                  const SizedBox(height: 20,),
                  reusableSignInSignUpButton(context, true, ()async{
                    setState(() {
                      isLoading = true;
                    });
                    try{
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _emailTextController.text.trim(),
                          password: _passwordTextController.text).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => const HomeScreen()));

                      }
                      );
                    }catch(e){
                      print(e);
                    }
                  }  ),
                  const SizedBox(height: 20,),
                 SignIn_Options(() => Navigator.push(context,
                     MaterialPageRoute(builder: (context)=>const SignUpScreen
                       ())), 'Sign Up','Don\'t have Account? ')
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

