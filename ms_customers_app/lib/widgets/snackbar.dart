import 'package:flutter/material.dart';


class MyMessageHandler{
 static void showSnackBar(var scaffoldKey, String message){
    scaffoldKey.currentState!.hideCurrentSnackBar();
    scaffoldKey.currentState!.showSnackBar(
        SnackBar(
            backgroundColor: Colors.grey.shade900,
            content: Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            duration: const Duration(milliseconds: 1500),
            width: 280.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),);
  }
}
/*    SnackBar(
         duration: const Duration(seconds:2),
         backgroundColor: Colors.yellow,
         content: 
          Text(message,
           textAlign: TextAlign.center,
           style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
             ),
            )) */