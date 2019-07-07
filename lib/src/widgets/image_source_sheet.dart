import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});

  Future<void> _handleImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source);
    // if (image != null) {
    //   File croppedImage = await ImageCropper.cropImage(
    //     sourcePath: image.path,
    //     ratioX: 1.0,
    //     ratioY: 1.0,
    //     toolbarColor: Theme.of(context).primaryColor,
    //     toolbarWidgetColor: Colors.blueGrey.shade900,
    //     toolbarTitle: 'Cut image',
    //   );
      onImageSelected(image);
    // }
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
              child: Text(
                'Camera'.toUpperCase(),
              ),
              onPressed: () => _handleImage(context, ImageSource.camera),
            ),
            FlatButton(
              child: Text(
                'Gallery'.toUpperCase(),
              ),
              onPressed: () => _handleImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }
}
