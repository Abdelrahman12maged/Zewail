import 'package:flutter/material.dart';

Widget defaultButton(
        {double width = double.infinity,
        //  Color background = Colors.blue,
        Color background = Colors.blue,
        required VoidCallback function,
        required String text}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "$text",
          style: TextStyle(
              color: Color.fromARGB(255, 231, 224, 224),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
Widget defaultTextform(
        {TextEditingController? controller,
        required TextInputType type,
        InputDecoration? content,

        //   String? validate(String? String)?,
        required String label,
        String? hint,
        IconData? prefix,
        Widget? sufix,
        bool isclick = true,
        bool obsecure = false,
        required Color colorenable,
        required Color colorfocus,
        StrutStyle? style,
        VoidCallback? ontap,
        VoidCallback? onpresedIcon,
        Function(String)? onchang,
        String? Function(String?)? validator}) =>
    TextFormField(
      strutStyle: style,
      textDirection: TextDirection.rtl,
      obscureText: obsecure,
      onChanged: onchang,
      onTap: ontap,
      controller: controller,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        fillColor: Colors.white,
        filled: true,
        label: Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorenable,
          ),
        ),
        suffixIcon: sufix,
        prefixIcon: IconButton(
          onPressed: onpresedIcon,
          icon: Icon(
            color: Color.fromARGB(255, 31, 101, 240),
            prefix,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorfocus),
            borderRadius: BorderRadius.circular(10)),
        enabled: isclick,
      ),
    );
