import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';


class MyAlertDialog{
  static void showMyDialog({
      required BuildContext context,
      required String title,
      required String content,
      required Function() tapNo,
      required Function() tapYes,
      })
      {
     showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: tapNo,

            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: tapYes,
            child: const Text('yes'),
          ),
        ],
      ),
    );

  }
}