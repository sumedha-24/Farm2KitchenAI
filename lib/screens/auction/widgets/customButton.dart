
// ignore_for_file: file_names

import 'package:flutter/material.dart';


Widget customButton (String buttonText,onPressed){
  return SizedBox(
    width: 100,
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
            color: Colors.white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        elevation: 3,
      ),
    ),
  );
}