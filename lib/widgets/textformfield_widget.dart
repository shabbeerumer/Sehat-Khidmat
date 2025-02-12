import 'package:flutter/material.dart';

Widget textformfield(String hintText , String lableText , controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          hintText: hintText,
          label: Text(lableText)),
    ),
  );
}
