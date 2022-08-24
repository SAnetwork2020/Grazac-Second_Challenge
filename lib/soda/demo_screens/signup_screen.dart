import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:second_challenge/soda/demo_screens/home_screen/home_screen_components/home_screen.dart';
import 'package:second_challenge/soda/demo_screens/reusable_widget.dart';
import 'package:second_challenge/soda/demo_screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  bool isLoading = false;
  late AnimationController controller;


  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(vsync: this,
        duration: const Duration(seconds: 1));
    controller.forward();
    controller.addListener(() {
      setState(() {
        print('${controller.value}');
      });
    });
    super.initState();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight:
          FontWeight.bold),),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(width: MediaQuery.of(context).size.width,height:
        MediaQuery.of(context).size.height,
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
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size
                  .height *.2,
                  20, 0),
              child: Column(
                children: [
                  AnimatedBuilder(
                      builder: (BuildContext context, Widget? child) =>
                      Transform.scale(
                        scale: controller.value,
                        child: logoWidget(imageName: 'assets/images/girl_5516806-removebg-preview.png'),
                      ),
                      animation: controller,
                      ),
                  // Image.asset('assets/images/girl_5516806-removebg-preview.png',
                  //   scale: animation.value,),

                  SizedBox(height: 20,),
                  reusableTextFormField('First Name', Icons.person, false,
                      _firstnameTextController),
                  SizedBox(height: 20,),
                  reusableTextFormField('Last Name', Icons.person, false,
                      _lastnameTextController),
                  SizedBox(height: 20,),
                  reusableTextFormField('Email Address', Icons.email, false,
                      _emailTextController),
                  SizedBox(height: 20,),
                  reusableTextFormField('Password', Icons.lock, true,
                      _passwordTextController),

                  SizedBox(height: 16,),
                  reusableSignInSignUpButton(context, false, () async{
                    setState(() {
                      isLoading = true;
                    });
                    try{
                      final newUser = await _auth
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text.trim(),
                          password: _passwordTextController.text,
                      ).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => HomeScreen()));
                        setState(() {
                          isLoading = false;
                        });
                      }
                      );
                    }catch(e){
                      print(e);
                    }

                  }),
                  SizedBox(height: 30,),
                  SignIn_Options(() => Navigator.push(context,
                      MaterialPageRoute(builder: (Context)=>SignInScreen())), 'Log '
                      'In', 'Already have Account? '
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
