
import 'package:flutter/material.dart';


void showSnackBarSuccessfully(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Data Saved Successfully"),
    ),
  );
}
void showSnackBarPleaseFill(BuildContext context,) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Please Fill All Feilds"),
    ),
  );
}
