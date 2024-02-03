import 'package:flutter/material.dart';

class Validator {
  Emptyvalidate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن ان يكون الحقل فارغ';
    }

    return null;
  }

  passvalidate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن ان يكون الحقل فارغ';
    }

    if (value.length < 6) {
      return 'لا يجب ان يقل الباسورد عن ستة احرف';
    }
    return null;
  }

  numvalidate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن ان يكون الحقل فارغ';
    }
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]\d{1,14}$');

    if (!phoneRegex.hasMatch(value)) {
      return 'ضع رقم هاتف صحيح';
    }
    if (value.length < 11) {
      return 'لا يجب ان يقل  عن 11 رقم';
    }
    if (value.length > 11) {
      return 'لا يجب ان يزيد  عن 11 رقم';
    }

    return null;
  }

  namevalidate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن ان يكون الحقل فارغ';
    }

    if (value.length < 10) {
      return 'الاسم قصير جدا اكتب الاسم الثلاثي علي الاقل';
    }

    return null;
  }

  gendervalidate(bool value) {
    if (!value) {
      return 'Please select a gender';
    }

    return null;
  }

  numpubvalidate(String value) {
    if (value.isEmpty) {
      return 'لا يمكن ان يكون الحقل فارغ';
    }

    return 'ضع رقم صحيح';
  }
}
