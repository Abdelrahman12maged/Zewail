import 'package:flutter/material.dart';

class errrowidget extends StatelessWidget {
  const errrowidget({super.key, required this.erromessage});
  final String erromessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      erromessage,
      style: TextStyle(fontSize: 20),
    );
  }
}
