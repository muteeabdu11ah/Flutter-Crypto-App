
import 'package:cryptocurrency_app/logIn_SignUp.dart/login_screen.dart';
import 'package:cryptocurrency_app/logIn_SignUp.dart/text_field_input.dart';
import 'package:cryptocurrency_app/ui/widgets/details/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  void dispose() {
    _emailController.dispose();
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
              AppBar(
                  backgroundColor: Color.fromARGB(31, 165, 165, 165),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Icon(
                              Icons.keyboard_return,
                              size: 30,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  )),
              //SVG IMAGE

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

              GestureDetector(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController.text);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => loginScreen()));
                  } on FirebaseAuthException catch (err) {
                    showsnackbar(context, err.message!);
                  }
                },
                child: Container(
                  height: 43,
                  child: Text(
                    'Send Email',
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
              Spacer(),

              //TRANSITION TO SIGN UP
            ],
          ),
        ),
      ),
    );
  }
}
