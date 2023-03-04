import 'package:cryptocurrency_app/logIn_SignUp.dart/login_screen.dart';
import 'package:cryptocurrency_app/ui/screens/privacypolicy.dart';
import 'package:cryptocurrency_app/ui/screens/termsandconditions.dart';
import 'package:cryptocurrency_app/ui/widgets/details/snackbar.dart';
import 'package:flutter/material.dart';

import 'firebase_auth.dart';
import 'text_field_input.dart';

class signUpScreen extends StatefulWidget {
  signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();

  bool value = false;

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SVG IMAGE
            const Spacer(),
            const Spacer(),
            Container(
              child: Image.asset(
                'assets/icon/logo.png',
                //color: Colors.green,
                height: 150,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 45)),
            Padding(padding: EdgeInsets.only(top: 20)),
            text_field(
              hintText: ' Name',
              textEditingController: _nameController,
              textInputType: TextInputType.text,
            ),
            //TEXT FIELD PASSWORD
            Spacer(),

            //TEXT FIELD EMAIL

            text_field(
              hintText: ' Email',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            //TEXT FIELD PASSWORD
            Spacer(),
            text_field(
              hintText: ' Password',
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),

            Row(children: [
              Checkbox(
                value: value,
                onChanged: (value) {
                  setState(() {
                    this.value = value!;
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => termsconditions()));
                },
                child: Container(child: Text('terms and conditions')),
              )
            ]),
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: (value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => privacyPolicy()));
                  },
                  child: Container(child: Text('Privacy policy')),
                )
              ],
            ),

            //LOGIN BUTTON
            GestureDetector(
              onTap: () async {
                if (value == false) {
                  showsnackbar(context, 'Accept the terms first');
                } else
                  (await authMethods().signUpUser(
                    context: context,
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                  ));
              },
              child: Container(
                height: 43,
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const ShapeDecoration(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            //TRANSITION TO LOGIN
            Container(
              child: Row(
                children: [
                  Spacer(),
                  Center(
                    child: Container(
                      child: const Text('Already have an account? '),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => loginScreen()));
                    },
                    child: Container(
                      child: const Text(
                        'Log in.',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5))
          ],
        ),
      )),
    );
  }
}
