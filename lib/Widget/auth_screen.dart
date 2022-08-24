import 'package:flutter/material.dart';
import 'package:second_challenge/Widget/constant.dart';

import 'login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: _size.width * .88, height: _size.height,
            child: Container(
              color: login_bg,
              child: LoginForm(),
            ),
          ), 
          CircleAvatar(
            radius: 25,
          )
        ],
      ),
    );
  }
}
