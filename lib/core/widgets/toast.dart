import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

customToast({
  required Color backgroundColor,
  required Color textColor,
  required String content,
}) {
  return Fluttertoast.showToast(
    msg: content,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    //timeInSecForIosWeb: 2,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}
