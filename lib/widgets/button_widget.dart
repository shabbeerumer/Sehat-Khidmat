import 'package:flutter/material.dart';

Widget mybutton(bgcolor, icon, iconcolor, text, textcolor , ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 50,
      width: double.infinity,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(25), color: bgcolor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconcolor,
          ),
          Text(
            text,
            style: TextStyle(color: textcolor),
          )
        ],
      ),
    ),
  );
}
