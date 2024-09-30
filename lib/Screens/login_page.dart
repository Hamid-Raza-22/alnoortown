import 'dart:convert';
import 'dart:ui';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/LoginViewModel/login_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:http/http.dart' as http;
import 'package:al_noor_town/Screens/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
    LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginViewModel loginViewModel =Get.put(LoginViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  void initState() {
    super.initState();
    loginViewModel.fetchAndSaveLoginData();
    roadDetailsViewModel.fetchAndSaveRoadDetailsData();
    blockDetailsViewModel.fetchAndSaveBlockDetailsData();
  }

  final storage =   FlutterSecureStorage();

  void _loginwithJWT() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://your-backend-url.com/login'), // Replace with your backend login URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Assuming the JWT is in the response body as 'token'
        final data = jsonDecode(response.body);
        String token = data['token'];

        // Store the JWT securely
        await storage.write(key: 'jwt', value: token);

        // Navigate to the HomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>   HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Login failed. Please try again.'.tr())),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }
  void _fetchUserData() async {
    final String? token = await storage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('https://your-backend-url.com/user-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle the successful response here
      // e.g., parse the JSON and update the UI
    } else {
      // Handle error here
    }
  }


  void _login() async {
  // context.setLocale(Locale('en')); // English set karne ke liye
  //   String email = _emailController.text.trim();
  //   String password = _passwordController.text.trim();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>   HomePage()),
    );
    //
    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    //
    //   // Login successful, navigate to the HomePage
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   );
    // } on FirebaseAuthException catch (e) {
    //   String errorMessage;
    //
    //   if (e.code == 'user-not-found'.tr()) {
    //     errorMessage = 'No user found for that email.'.tr();
    //   } else if (e.code == 'wrong-password') {
    //     errorMessage = 'Wrong password provided for that user.'.tr();
    //   } else {
    //     errorMessage = 'Login failed. Please try again later.'.tr();
    //   }
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(errorMessage)),
    //   );
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('An unexpected error occurred: $e'.tr())),
    //   );
    // }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image with blur effect
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
              child: Padding(
                padding: MediaQuery.of(context).size.width > 600
                    ?   EdgeInsets.symmetric(horizontal: 50.0)
                    :   EdgeInsets.all(30.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'login'.tr(),
                          style:   TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC69840),
                          ),
                        ),
                          SizedBox(height: 20),
                        FadeInUp(
                          duration:   Duration(milliseconds: 1800),
                          child: Container(
                            padding:   EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color:   Color(0xFFC69840)),
                              boxShadow:   [
                                BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:   EdgeInsets.all(8.0),
                                  decoration:   BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "user_id_hint".tr(),
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "user_id".tr(),
                                      labelStyle:   TextStyle(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "password".tr(),
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "password".tr(),
                                      labelStyle:   TextStyle(color: Color(0xFFC69840)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color:   Color(0xFFC69840),
                                        ),
                                        onPressed: _togglePasswordVisibility,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                          SizedBox(height: 30),
                        FadeInUp(
                          duration:   Duration(milliseconds: 1900),
                          child: GestureDetector(
                            onTap: _login,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:   Color(0xFFC69840),
                              ),
                              child:  Center(
                                child: Text(
                                  "login".tr(),
                                  style:   TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                          SizedBox(height: 20),
                        FadeInUp(
                          duration:   Duration(milliseconds: 2000),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   SignUpPage()),
                              );
                            },
                            child: Text(
                              "dont_have_an_account".tr(),
                              style:   TextStyle(
                                color: Color(0xFFC69840),
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}