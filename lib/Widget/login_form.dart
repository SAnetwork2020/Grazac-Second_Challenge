import 'package:flutter/material.dart';
import 'package:second_challenge/Widget/constant.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.symmetric(
         horizontal: MediaQuery.of(context).size.width * .13,
       ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                ),
              ),
              TextButton(
                onPressed: (){},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.white),
                  ),
              ),
              const Spacer(flex: 2,),
            ],
        ),
      ),
    );
  }
}
