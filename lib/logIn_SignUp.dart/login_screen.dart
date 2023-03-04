
import 'package:cryptocurrency_app/logIn_SignUp.dart/forget_password.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/signup_screen.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/text_field_input.dart';
import 'package:flutter/material.dart';


import 'firebase_auth.dart';

class loginScreen extends StatelessWidget {
  loginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SVG IMAGE
            Spacer(),
            Spacer(),
            Container(
              child: Image.asset(
                'assets/icon/logo.png',
                //  color: Colors.black,
                height: 150,
              ),
            ),
            Spacer(),
            //TEXT FIELD EMAIL
            text_field(
              hintText: ' Email',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            //TEXT FIELD PASSWORD
            SizedBox(
              height: 20,
            ),
            text_field(
              hintText: ' Password',
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),
            SizedBox(
              height: 30,
            ), //LOGIN BUTTON
            GestureDetector(
              onTap: () async {
                await authMethods().signInUser(
                  context: context,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
              child: Container(
                height: 43,
                child: Text(
                  'Log In',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ForgotScreen()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                height: 43,
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.red),
                ),
                width: double.infinity,
                alignment: Alignment.topRight,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),

            //TRANSITION TO SIGN UP
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.2)),
                  Container(child: Text('Don\'t have an account? ')),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => signUpScreen()));
                    },
                    child: Container(
                      child: Text(
                        'Sign up.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
