import 'package:flutter/material.dart';

showsnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Color.fromARGB(151, 218, 218, 218),
    content: 
  Text(message)));
}
