import 'dart:math';

import 'package:flutter/material.dart';

class luckynumber extends StatefulWidget {
  @override
  State<luckynumber> createState() => _luckynumberState();
}

class _luckynumberState extends State<luckynumber> {
  
  
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    random(100000, 999999);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Lucky Number Generator',
                  style: TextStyle(fontSize: 30),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/icon/lottery.png')),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: Colors.green,
              child: TextButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text(
                    'Generate Number',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Spacer(),
            Container(
                child: Text(
              'Your lucky 6-digit lucky number is ',
              style: TextStyle(fontSize: 20),
            )),
            Spacer(),
            Container(
                child: Text(
              random(10000, 999999).toString(),
              style: TextStyle(
                  letterSpacing: 10, fontSize: 30, fontWeight: FontWeight.bold),
            )),
            Spacer(),
          ]),
    );
  }
}
