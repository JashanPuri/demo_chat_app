import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final Function(File imageFile) pickUserImage;

  PickImage(this.pickUserImage);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  final _imagePicker = ImagePicker();

  File _userImageFile;

  void _pickImage() async {
    final _pickedImage = await _imagePicker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final _pickedFile = File(_pickedImage.path);
    setState(() {
      _userImageFile = _pickedFile;
    });

    widget.pickUserImage(_pickedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _userImageFile == null
              ? null
              : FileImage(
                  _userImageFile,
                ),
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
