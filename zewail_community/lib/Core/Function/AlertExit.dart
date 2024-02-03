import 'package:flutter/material.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text(
              "تنبيه",
              style: TextStyle(fontSize: 20),
            )),
            content: Text(
              'هل تريد الخروج من التطبيق',
              style: TextStyle(fontSize: 20),
              textDirection: TextDirection.rtl,
            ),
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(false); // إغلاق الحوار واسترجاع false
                    },
                    child: Text('لا'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      Navigator.of(context)
                          .pop(true); // إغلاق الحوار واسترجاع true
                    },
                    child: Text('نعم'),
                  ),
                ],
              )
            ],
          );
        },
      ) ??
      false; // إرجاع قيمة افتراضية في حالة عدم الضغط على أي زر
}
