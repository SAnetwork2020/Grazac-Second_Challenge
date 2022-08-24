import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:second_challenge/soda/demo_screens/home_screen/home_screen_components/home_screen.dart';
import 'package:second_challenge/Widget/reusable_widget.dart';
import 'package:second_challenge/soda/demo_screens/sign_in/signin_screen.dart';
import 'package:second_challenge/soda/demo_screens/signup_screen/components/signup_screen_components.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _firstnameTextController = TextEditingController();
  final TextEditingController _lastnameTextController = TextEditingController();
  bool isLoading = false;
  late AnimationController controller;

  bool isPasswordType = true;

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
    _passwordTextController.dispose();
    _emailTextController.dispose();
    _firstnameTextController.dispose();
    _lastnameTextController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(width: MediaQuery.of(context).size.width,height:
          MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.yellow,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20,
                    20, 30),
                child: Column(
                  children: [
                    AnimatedBuilder(
                        builder: (BuildContext context, Widget? child) =>
                        Transform.scale(
                          scale: controller.value,
                          child: const logoWidget(imageName: 'assets/images/girl_5516806-removebg-preview.png'),
                        ),
                        animation: controller,
                        ),
                    const SizedBox(height: 10,),
                    const Text('SIGN UP', style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w600,fontSize: 48),),
                    const SizedBox(height: 10,),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          TextFormField(
                            controller: _firstnameTextController,
                            style: TextStyle(color: Colors.black.withOpacity(.7)),
                            keyboardType: TextInputType.text,
                            decoration: createPassword_decoration.copyWith(
                              hintText: 'First Name', prefixIcon: const Icon(Icons
                                .person_rounded, color: Colors.black,),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: _lastnameTextController,
                            style: TextStyle(color: Colors.black.withOpacity(.7)),
                            keyboardType: TextInputType.text,
                            decoration: createPassword_decoration.copyWith(
                              hintText: 'Last Name', prefixIcon: const Icon(Icons
                                .person_rounded, color: Colors.black,),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: _emailTextController,
                            style: TextStyle(color: Colors.black.withOpacity(.7)),
                            keyboardType: TextInputType.emailAddress,
                            decoration: createPassword_decoration.copyWith(
                              hintText: 'Email Address', prefixIcon: const Icon(Icons
                                .email_rounded, color: Colors.black,),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: _passwordTextController,
                            obscureText: isPasswordType,
                            decoration: createPassword_decoration.copyWith(
                              hintText: 'Password',prefixIcon: const Icon(Icons.lock,color: Colors.black),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      isPasswordType = !isPasswordType;
                                    });
                                  }, icon: Icon(isPasswordType? Icons
                                  .visibility_off: Icons.visibility),color:
                              Colors.black)
                            ),
                            onChanged: (pass) {_formKey.currentState!.validate
                              ();},
                            validator: (pass){
                              if(pass!.isEmpty){
                                return 'Please enter password';
                              }else{
                                bool result = validatePassword(pass);
                                if (result){
                                  return null;
                                }else{
                                  return " Password should contain Uppercase,\n "
                                      "smaller case letters, \nNumber(s) & \nSpecial Character(s)";
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 16,),
                          //Sign_UP_BUTTON
                          SizedBox(height: 58,width: MediaQuery.of(context)
                              .size.width,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all
                                    (RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)){
                                      return Colors.black26;
                                    } return Colors.white;
                                  },
                                  ),),
                                onPressed: password_strength != 1 ? null
                                : ()async{
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
                                        (context) => const HomeScreen()));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                  );
                                }catch(e){
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print(e);
                                }
                              } , child: const Text('Sign Up',style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SignIn_Options(() => Navigator.push(context,
                        MaterialPageRoute(builder: (Context)=>const SignInScreen())), 'Log '
                        'In', 'Already have Account? '
                    ),
                    const SizedBox(height: 16,),
                    social_media_options()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double password_strength = 0;
// 0: No password
// 1/4: Weak
// 2/4: Medium
// 3/4: Strong
// 4/4: Great or Excellent

  bool validatePassword(String pass){
    String _password = pass.trim();
    if(_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    }else if (_password.length < 6){
      setState((){
        password_strength = 1/4;
      });
    }else if (_password.length < 8){
      setState((){
        password_strength = 2/4;
      });
    }else{
      if (pass_valid.hasMatch(_password)){
        setState((){
          password_strength = 4/4;
        });
        return true;
      }else{
        setState((){
          password_strength = 3/4;
        });
        return false;
      }
    }
    return false;
  }
}
