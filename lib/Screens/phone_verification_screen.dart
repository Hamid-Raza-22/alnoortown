// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class PhoneVerificationDialog extends StatefulWidget {
//   final String phoneNumber;
//   final VoidCallback onVerificationCompleted;
//
//     PhoneVerificationDialog({
//     super.key,
//     required this.phoneNumber,
//     required this.onVerificationCompleted,
//   });
//
//   @override
//   PhoneVerificationDialogState createState() => PhoneVerificationDialogState();
// }
//
// class PhoneVerificationDialogState extends State<PhoneVerificationDialog> {
//   final TextEditingController _codeController = TextEditingController();
//   String? _verificationId;
//   int? _resendToken;
//   bool _isLoading = false;
// // Set to true initially to show Resend Code button
//
//   @override
//   void initState() {
//     super.initState();
//     _verifyPhoneNumber();
//     _focusCodeField();
//   }
//
//   void _focusCodeField() {
//     Future.delayed(Duration.zero, () {
//       FocusScope.of(context).requestFocus(FocusNode());
//     });
//   }
//
//   void _verifyPhoneNumber({int? resendToken}) async {
//     setState(() {
//       _isLoading = true;
// // Make sure this is set to true so that the Resend Code button is visible
//     });
//
//     try {
//       await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: widget.phoneNumber,
//         forceResendingToken: resendToken,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           if (!mounted) return;
//           await FirebaseAuth.instance.signInWithCredential(credential);
//           widget.onVerificationCompleted();
//           Navigator.of(context).pop(); // Close the dialog
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           if (!mounted) return;
//           setState(() {
//             _isLoading = false;
//           });
//           _showSnackBar('Verification failed: ${e.message}');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           if (!mounted) return;
//           setState(() {
//             _verificationId = verificationId;
//             _resendToken = resendToken; // Ensure the token is saved
//             _isLoading = false;
//             if (kDebugMode) {
//               print('Resend Token: $_resendToken');
//             } // Debugging line
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           if (!mounted) return;
//           setState(() {
//             _verificationId = verificationId;
//           });
//         },
//       );
//     } catch (e) {
//       if (!mounted) return;
//       setState(() {
//         _isLoading = false;
//       });
//       _showSnackBar('An error occurred while verifying: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _codeController.dispose();
//     super.dispose();
//   }
//
//   void _verifyCode() async {
//     final code = _codeController.text.trim();
//
//     if (_verificationId != null && code.isNotEmpty) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       try {
//         final PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: _verificationId!,
//           smsCode: code,
//         );
//
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         widget.onVerificationCompleted();
//         Navigator.of(context).pop(); // Close the dialog
//       } catch (e) {
//         _showSnackBar('Failed to verify code: $e');
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else {
//       _showSnackBar('Please enter a valid verification code.');
//     }
//   }
//
//   void _resendCode() {
//     if (_resendToken != null) {
//       if (kDebugMode) {
//         print('Resending code with token: $_resendToken');
//       } // Debugging line
//       _verifyPhoneNumber(resendToken: _resendToken);
//     } else {
//       _showSnackBar('Resend token is null, cannot resend code.');
//     }
//   }
//
//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style:   TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Column(
//       children: [
//           Text(
//           'Phone Verification',
//           style: TextStyle(
//             fontSize: 26.0,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//           SizedBox(height: 20),
//         Text(
//           'We’ve sent a verification code to ${widget.phoneNumber}',
//           style: TextStyle(
//             fontSize: 16.0,
//             color: Colors.grey[600],
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCodeInputField() {
//     return TextField(
//       controller: _codeController,
//       decoration: InputDecoration(
//         labelText: 'Verification Code',
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//       ),
//       keyboardType: TextInputType.number,
//       textAlign: TextAlign.center,
//       enabled: !_isLoading,
//       inputFormatters: [
//         LengthLimitingTextInputFormatter(6),
//         FilteringTextInputFormatter.digitsOnly,
//       ],
//     );
//   }
//
//   Widget _buildActionButton() {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: _codeController.text.trim().isEmpty || _isLoading
//               ? null
//               : _verifyCode,
//           style: ElevatedButton.styleFrom(
//             padding:   EdgeInsets.symmetric(vertical: 16.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             textStyle:   TextStyle(fontSize: 18.0),
//           ),
//           child:   Text('Verify'),
//         ),
//           SizedBox(height: 10),
//         TextButton(
//           onPressed: _isLoading ? null : _resendCode,
//           child:   Text('Resend Code'),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLoadingIndicator() {
//     return   Center(
//       child: CircularProgressIndicator(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       child: Padding(
//         padding:   EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildHeader(),
//                 SizedBox(height: 20),
//               _buildCodeInputField(),
//                 SizedBox(height: 20),
//               _isLoading ? _buildLoadingIndicator() : _buildActionButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
