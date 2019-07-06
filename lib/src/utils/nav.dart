import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page) {
  return Navigator.push(
      context, CupertinoPageRoute(builder: (context) => page));
}

Future pushReplacement(BuildContext context, Widget page) {
  return Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => page));
}

bool pop(BuildContext context, {toReturn}) {
  return Navigator.pop(context, toReturn);
}