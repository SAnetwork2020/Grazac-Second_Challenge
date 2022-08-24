import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


Text SignIn_Options(Function() goto,String change, String original) {
  return Text.rich(
      TextSpan(style:const TextStyle(color:Colors.white70),
          children: [
            TextSpan(text:original
            // isNewUser?
            // 'Already a User?'
            //     'Don\'t have account? '
            ),
            TextSpan(text:change,
            // isNewUser?
            // 'Sign Up',
                recognizer: TapGestureRecognizer()..onTap = goto,
                style: const TextStyle(color:
                Colors.white, fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2)),
          ])
  );
}

SizedBox reusableSignInSignUpButton(BuildContext context, bool isLogin,
    Function() onTap ){
  return SizedBox(height: 58,width: MediaQuery.of(context).size.width, child:
  ElevatedButton(
    onPressed: onTap,
    child: Text(isLogin
        ?'SIGN IN':'SIGN UP',
      style: TextStyle(
        color: Colors.black87, fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)){
          return Colors.black26;
        } return Colors.white;
      },
    ),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
    )
    ),
  );
}


class logoWidget extends StatelessWidget {
  const logoWidget({
    Key? key, required this.imageName,
  }) : super(key: key);
  final String imageName;
  @override
  Widget build(BuildContext context) {
    return Image.asset(imageName,width: 248, height: 248,);
  }
}


TextFormField reusableTextFormField(String text, IconData icon, bool
isPasswordType, TextEditingController controller)
=> TextFormField(
  controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(.9)),
  decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white70,),
  labelText: text,
  labelStyle: TextStyle(color: Colors.white.withOpacity(.9)),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.white.withOpacity(.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.8),
      borderSide: BorderSide(width: 0, style: BorderStyle.none),
    ),
  ),
  keyboardType: isPasswordType
      ?TextInputType.text
      :TextInputType.emailAddress,
);