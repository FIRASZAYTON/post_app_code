import 'package:flutter/material.dart';

Widget TextFieldWidget(
    {required TextEditingController Controller,
    required String text,
    required TextStyle style,
    required int min,
    required int max}) {
  ;
  return TextFormField(
    cursorColor: Colors.black87,
    style: style,
    validator: (value) => value!.isEmpty ? "$text can't be empty" : null,
    controller: Controller,
    decoration: InputDecoration(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      hintText: text,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            width: 2.0, style: BorderStyle.solid, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    maxLines: max,
    minLines: min,
  );
}
