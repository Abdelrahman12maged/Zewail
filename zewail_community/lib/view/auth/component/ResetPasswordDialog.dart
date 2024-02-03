import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../../Core/Constant/constants.dart';
import '../../../Core/Constant/links.dart';

import '../../../Core/Function/Api.dart';
import '../../../Core/Function/validation.dart';

class ResetPasswordDialog extends StatefulWidget {
  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController _phoneNumberController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'سيتم ارسال كلمة سر جديدة الي الواتساب تأكد ان لديك واتساب علي الرقم ',
        style: TextStyle(fontSize: 20),
      ),
      content: Form(
        key: formstate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              validator: (val) {
                return Validator().numvalidate(val!);
              },
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'رقم الهاتف'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.kPrimaryColor,
          ),
          onPressed: () async {
            if (formstate.currentState!.validate()) {
              // Send the new password to the provided phone number
              final phoneNumber = _phoneNumberController.text;
              // Implement your logic to send the password here
              _sendPasswordToPhoneNumber(phoneNumber);
              Navigator.of(context).pop();
              showSnackbar(
                  context: context,
                  message: 'تم ارسال الرسالة الي الواتساب',
                  colorback: Color.fromARGB(255, 114, 174, 116),
                  color: Colors.white);
            }

            //  Navigator.of(context).pop();
          },
          child: Text(
            'ارسل الباسورد الي الواتساب',
            style: TextStyle(color: Color.fromARGB(255, 242, 242, 242)),
          ),
        ),
      ],
    );
  }

  void _sendPasswordToPhoneNumber(String phoneNumber) async {
    // Implement your logic to generate and send a new password
    try {
      var response = await Api().post(
        url: '$baseurl/change-password?st_mobile=$phoneNumber',
        body: {
          "st_mobile": phoneNumber,
        },
      );
    } catch (e) {
      print(e.toString());
    }

    // You can use any method to send the password (e.g., SMS, email, etc.)
    // For demonstration purposes, we'll just print it here.
  }
}
