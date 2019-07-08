import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  Future<void> _handleImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    onImageSelected(image);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.camera_alt),
                  SizedBox(width: 5),
                  Text(
                    'Camera'.toUpperCase(),
                  ),
                ],
              ),
              onPressed: () => _handleImage(context, ImageSource.camera),
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Icon(Icons.image),
                  SizedBox(width: 5),
                  Text(
                    'Gallery'.toUpperCase(),
                  ),
                ],
              ),
              onPressed: () => _handleImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }
}
