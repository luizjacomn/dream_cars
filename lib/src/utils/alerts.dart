import 'package:flutter/material.dart';

alert(BuildContext context, String title, String msg, {Function callback}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              if (callback != null) callback();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

snack(BuildContext context, String msg, {Function onPressed}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      action: onPressed != null
          ? SnackBarAction(
              label: 'OK',
              textColor: Colors.yellowAccent,
              onPressed: onPressed,
            )
          : null,
    ),
  );
}
