import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      backgroundColor: Color.fromARGB(255, 54, 244, 108),
      semanticsLabel: "تحميل....",
    ));
  }
}
