import 'package:al_noor_town/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class PolicyDialog extends StatefulWidget {
  const PolicyDialog({Key? key}) : super(key: key);

  @override
  _PolicyDialogState createState() => _PolicyDialogState();
}

class _PolicyDialogState extends State<PolicyDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: const Text(
        "App Policies",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "By using this app, you agree to the following policies:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            _buildPolicyText("- This app collects location data to enable tracking and share your location with the server even when the app is closed or not in use."),
            _buildPolicyText("- This app requires access to your camera for posting images to the server through APIs."),
            _buildPolicyText("- This app uses APIs to share app data onto the server."),
            _buildPolicyText("- This app uses storage to store app data."),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                    child: const Text(
                      "I agree to the above policies",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Handle "Deny" button press
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text(
            "Deny",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: _isChecked
              ? () {
            _requestPermissions();
          }
              : null, // Disable the button if checkbox is not checked
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            backgroundColor: _isChecked ? Colors.green : Colors.grey,
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Agree"),
        ),
      ],
    );
  }

  Widget _buildPolicyText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.4),
      ),
    );
  }


  Future<void> _requestPermissions() async {
    if (await Permission.notification.request().isDenied) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return;
    }

    if (await Permission.location.request().isDenied) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      Get.offNamed('/login');
    }
  }
}