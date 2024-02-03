import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../../../Core/Constant/constants.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImagePage({required this.imageUrl});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  void _saveNetworkImage(BuildContext context, String imagePath) async {
    try {
      bool? success = await GallerySaver.saveImage(imagePath);
      if (success!) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تم الحفظ'),
              content: Text('تم حفظ الصورة في المعرض'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to save image');
      }
    } catch (e) {
      print('Error saving image: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: InteractiveViewer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.contain, // أو BoxFit.cover حسب التفضيل
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 10,
          child: IconButton(
              onPressed: () async {
                _saveNetworkImage(context, widget.imageUrl);
              },
              icon: Icon(
                Icons.download,
                size: 40,
                color: Colors.blue,
              )),
        )
      ],
    );
  }
}
