import 'package:flutter/material.dart';

Widget buildWorkStatusField(String label,TextEditingController controller, ValueChanged<String> onChanged, ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,

        style: TextStyle(

          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFFC69840),
        ),
      ),
      SizedBox(height: 8),
      TextField(

        onChanged: onChanged,
        maxLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC69840)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
      ),
    ],
  );
}
