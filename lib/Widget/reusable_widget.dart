
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


Text SignIn_Options(Function() goto,String change, String original) {
  return Text.rich(
      TextSpan(style:TextStyle(color:Colors.black.withOpacity(.6)),
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
                style: const TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w700,
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
      style: const TextStyle(
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
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(.7)),
  decoration: InputDecoration(
    prefixIcon: Icon(icon, color: Colors.black,),
  labelText: text,
  labelStyle: TextStyle(color: Colors.black.withOpacity(.9)),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.white.withOpacity(.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.8),
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
  ),
  keyboardType: isPasswordType
      ?TextInputType.text
      :TextInputType.emailAddress,
);

TextFormField reusablePasswordFormField(String text, IconData icon, bool
isPasswordType, TextEditingController controller,Function
    (bool check)visibility)
=> TextFormField(
  controller: controller,
  obscureText: isPasswordType,
  enableSuggestions: isPasswordType,
  autocorrect: !isPasswordType,
  cursorColor: Colors.black,
  style: TextStyle(color: Colors.black.withOpacity(.7)),
  decoration: InputDecoration(
    prefixIcon: Icon(icon, color: Colors.black,),
    labelText: text,
    labelStyle: TextStyle(color: Colors.black.withOpacity(.9)),
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    fillColor: Colors.white.withOpacity(.3),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.8),
      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
    ),
  ),
  keyboardType: isPasswordType
      ?TextInputType.text
      :TextInputType.emailAddress,
);

OutlineInputBorder outlineborder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(30.8),
  borderSide: const BorderSide(width: 1, color: Colors.white10,
      style: BorderStyle
      .solid),
);
InputDecoration createPassword_decoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black.withOpacity(.9)),
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: Colors.white.withOpacity(.3),
  border: outlineborder,
  focusedBorder: outlineborder
);
Column social_media_options() {
  return Column(
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 100,
              child: Divider(
                thickness: 2,
                color: Colors.black.withOpacity(.6),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('or', style: TextStyle(color: Colors.black.withOpacity(.6),
                fontWeight: FontWeight.w700, fontSize: 18),),
          ),
          SizedBox(width: 100,
              child: Divider(
                thickness: 2,
                color: Colors.black.withOpacity(.6),
              )),
        ],
      ),
      const SizedBox(height: 16,),

      SizedBox(width: 500,
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const CircleBorder()
                  ),
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(height: 30,width: 30,
                        child: Image.asset('assets/images/google_icon.png',)),
                  )),
            ),
            SizedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const CircleBorder()
                  ),
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(height: 30,width: 30,
                        child: Image.asset('assets/images/fb-bg.jpg',)),
                  )),
            ),
            SizedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const CircleBorder()
                  ),
                  onPressed: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(height: 30,width: 30,
                        child: Image.asset('assets/images/logo-apple-2048.png',)),
                  )),
            ),
          ],
        ),
      ),
    ],
  );
}