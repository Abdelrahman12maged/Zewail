import 'package:flutter/material.dart';

import '../../../Core/Constant/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  bool? isloading = false;
  PrimaryButton(
      {super.key, required this.text, required this.onTap, this.isloading});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(double.maxFinite, 53),
            backgroundColor: MyColors.kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: isloading == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,

                // as elevated button gets clicked we will see text"Loading..."
                // on the screen with circular progress indicator white in color.
                //as loading gets stopped "Submit" will be displayed
                children: const [
                  Text(
                    'جار التحميل...',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ],
              )
            : Text(text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)));
  }
}
