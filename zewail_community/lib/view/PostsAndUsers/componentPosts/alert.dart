import 'package:flutter/material.dart';

class CustomActionoptin extends StatelessWidget {
  final void Function() onDeleteConfirmed;

  final void Function()? onEdit;
  String? titleEdit;
  final String titleDelete;
  final String contenttitleDelete;
  final String contenDelte;

  CustomActionoptin(
      {required this.onDeleteConfirmed,
      this.onEdit,
      this.titleEdit,
      required this.titleDelete,
      required this.contenttitleDelete,
      required this.contenDelte});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleEdit == null
                ? Container()
                : ListTile(
                    onTap: onEdit,
                    title: Text(
                      " $titleEdit",
                      style: TextStyle(fontSize: 18),
                      textDirection: TextDirection.rtl,
                    ),
                    leading: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
            Divider(height: 0),
            ListTile(
              onTap: () {
                // Show confirmation dialog before deleting the post
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(" $contenttitleDelete"),
                    content: Text("$contenDelte"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Dismiss confirmation dialog
                        },
                        child: Text("إلغاء"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Dismiss confirmation dialog
                          onDeleteConfirmed(); // Notify parent widget to delete the post
                        },
                        child: Text("حذف"),
                      ),
                    ],
                  ),
                );
              },
              title: Text(
                "$titleDelete",
                style: TextStyle(fontSize: 18, color: Colors.red),
                textDirection: TextDirection.rtl,
              ),
              leading: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
