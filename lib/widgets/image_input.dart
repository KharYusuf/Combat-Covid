import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  final String url;

  ImageInput(this.onSelectImage, [this.url]);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;
  final picker = ImagePicker();

  Future<void> _takePicture() async {
    final _pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (_pickedFile == null) {
      return;
    }
    setState(() {
      _image = File(_pickedFile.path);
    });
    widget.onSelectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            onPressed: _takePicture,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _image != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                )
              : widget.url != null
                  ? Image.network(
                      widget.url,
                      fit: BoxFit.cover,
                      height: double.infinity,
                    )
                  : Text(
                      'No Image Taken',
                      textAlign: TextAlign.center,
                    ),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
