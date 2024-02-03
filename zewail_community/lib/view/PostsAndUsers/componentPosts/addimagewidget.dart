import 'dart:io';

import 'package:flutter/material.dart';

class AddImageWidget extends StatefulWidget {
  AddImageWidget({Key? key}) : super(key: key);

  @override
  _AddImageWidgetState createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 30,
      child: Column(
        children: [
          if (_imageFile != null) ...[
            Image.file(_imageFile!),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
