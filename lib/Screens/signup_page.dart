import 'dart:ui';
import 'package:al_noor_town/Screens/phone_verification_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../Globals/globals.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
    SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  File? _image;




  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading:   Icon(Icons.photo_library, color: customColor),
                title: Text('gallery'.tr(), style:   TextStyle(color: customColor)),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading:   Icon(Icons.camera_alt, color: customColor),
                title:  Text('camera'.tr(), style:   TextStyle(color: customColor)),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColor, // Match the AppBar gradient or set a transparent color
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.app_registration, color: Colors.white, size: 28), // Icon/logo
            SizedBox(width: 10), // Spacing between icon and title
            Text(
              'sign_up'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700, // Slightly bolder weight
                fontSize: 24, // Further increased font size for emphasis
                fontFamily: 'Roboto', // Example of a custom font
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>   LoginPage()),
            );
          },
        ),
        actions: [
          IconButton(
            icon:   Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              // Implement your help action here
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [customColor, customColor.withOpacity(1), Colors.orangeAccent], // Added a third color for depth
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        elevation: 0.0, // Slightly increased elevation for a more prominent shadow
        shadowColor: customColor.withOpacity(0.8), // Darker shadow for better definition
        iconTheme:   IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent, // Transparent background to avoid white showing through
      ),
        body: Stack(
        children: [
          // Background image
          Container(
            decoration:   BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/gate_view.png'), // Path to your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Blurring effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.3), // Optional: Adjust overlay color and opacity
            ),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context,  raints) {
                  return Container(
                    padding:   EdgeInsets.all(20),
                    margin:   EdgeInsets.all(20),
                    width:  raints.maxWidth > 600 ? 500 :  raints.maxWidth * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset:   Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () => _showImageSourceOptions(context),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: customColor.withOpacity(0.2),
                              backgroundImage: _image != null ? FileImage(_image!) : null,
                              child: _image == null
                                  ?   Icon(
                                  Icons.camera_alt, color: customColor, size: 50)
                                  : null,
                            ),
                          ),
                            SizedBox(height: 30),
                          _buildTextField(
                            controller: _nameController,
                            label: 'town_name'.tr(),
                            icon: Icons.location_city,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_town_name'.tr();
                              }
                              return null;
                            },
                          ),
                            SizedBox(height: 20),
                          _buildTextField(
                            controller: _addressController,
                            label: 'town_address'.tr(),
                            icon: Icons.map,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_town_address'.tr();
                              }
                              return null;
                            },
                          ),
                            SizedBox(height: 20),
                          _buildTextField(
                            controller: _ownerController,
                            label: 'owner_name'.tr(),
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_owner_name'.tr();
                              }
                              return null;
                            },
                          ),
                            SizedBox(height: 20),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              labelText: 'contact_number'.tr(),
                              labelStyle:   TextStyle(color: customColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:   BorderSide(color: customColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:   BorderSide(
                                  color: customColor,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            initialCountryCode: 'PK',
                            onChanged: (phone) {
                              _contactNumberController.text =
                                  phone.completeNumber;
                            },
                          ),
                            SizedBox(height: 20),
                          _buildTextField(
                            controller: _emailController,
                            label: 'email'.tr(),
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_email_address'.tr();
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(
                                  value)) {
                                return 'please_enter_valid_email'.tr();
                              }
                              return null;
                            },
                          ),
                            SizedBox(height: 20),
                          _buildTextField(
                            controller: _passwordController,
                            label: 'password'.tr(),
                            icon: Icons.lock,
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_password'.tr();
                              }
                              if (value.length < 6) {
                                return 'password_must_be_6_characters'.tr();
                              }
                              return null;
                            },
                          ),
                            SizedBox(height: 20),
                          _buildTextField(
                            controller: _confirmPasswordController,
                            label: 'confirm_password'.tr(),
                            icon: Icons.lock,
                            obscureText: !_isPasswordVisible,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'passwords_do_not_match'.tr();
                              }
                              return null;
                            },
                          ),
                          SwitchListTile(
                            title:  Text(
                              'show_passwords'.tr(),
                              style: TextStyle(color: customColor),
                            ),
                            value: _isPasswordVisible,
                            onChanged: (bool value) {
                              setState(() {
                                _isPasswordVisible = value;
                              });
                            },
                            activeColor: customColor,
                          ),
                            SizedBox(height: 20),
                          _isLoading
                              ? _buildLoadingIndicator()
                              : ElevatedButton(
                            onPressed: _signUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: customColor,
                              padding:   EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 40.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 5.0,
                            ),
                            child:  Text(
                              'sign_up'.tr(),
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }






  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style:   TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle:   TextStyle(color: customColor),
        prefixIcon: Icon(icon, color: customColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:   BorderSide(color: customColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:   BorderSide(
            color: customColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(customColor),
          ),
          SizedBox(height: 20),
          Text(
            'Signing up, please wait...',
            style: TextStyle(color: customColor),
          ),
        ],
      ),
    );
  }
  void _showPhoneVerificationDialog(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PhoneVerificationDialog(
          phoneNumber: _contactNumberController.text,
          onVerificationCompleted: () {
            _clearForm();
            // Handle verification completion here
          },
        );
      },
    );
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create a user with email and password
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Send email verification
        await userCredential.user?.sendEmailVerification();

        // Upload image to Firebase Storage (if necessary)
        String? imageUrl;
        if (_image != null) {
          imageUrl = await _uploadImage();
        }

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('towns').doc(userCredential.user?.uid).set({
          'town_name': _nameController.text,
          'town_address': _addressController.text,
          'owner_name': _ownerController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'image': imageUrl,
          'phone': _contactNumberController.text, // Storing phone number
        });

        // Show a message to ask the user to verify their email
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('sign_up_successful'.tr()),
            backgroundColor: Colors.green,
          ),
        );

     _showPhoneVerificationDialog(context, _contactNumberController.text);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('failed_to_sign_up $e'.tr()),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String?> _uploadImage() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('Towns/${DateTime.now()}.jpg');
      final uploadTask = storageRef.putFile(_image!);
      final snapshot = await uploadTask.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  void _clearForm() {
    _nameController.clear();
    _addressController.clear();
    _ownerController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _contactNumberController.clear();

    setState(() {
      _image = null;
    });
  }
}
