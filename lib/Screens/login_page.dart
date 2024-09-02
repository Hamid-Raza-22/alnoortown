import 'dart:ui';
import 'package:al_noor_town/Screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );

    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    //
    //   // Login successful, navigate to the HomePage
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const HomePage()),
    //   );
    // } on FirebaseAuthException catch (e) {
    //   String errorMessage;
    //
    //   if (e.code == 'user-not-found') {
    //     errorMessage = 'No user found for that email.';
    //   } else if (e.code == 'wrong-password') {
    //     errorMessage = 'Wrong password provided for that user.';
    //   } else {
    //     errorMessage = 'Login failed. Please try again later.';
    //   }
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(errorMessage)),
    //   );
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('An unexpected error occurred: $e')),
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
            decoration: const BoxDecoration(
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
                    ? const EdgeInsets.symmetric(horizontal: 50.0)
                    : const EdgeInsets.all(30.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width > 600 ? 500 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC69840),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1800),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: const Color(0xFFC69840)),
                              boxShadow: const [
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
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "User ID",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "User ID",
                                      labelStyle: const TextStyle(color: Color(0xFFC69840)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      labelText: "Password",
                                      labelStyle: const TextStyle(color: Color(0xFFC69840)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xFFC69840),
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
                        const SizedBox(height: 30),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: GestureDetector(
                            onTap: _login,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFC69840),
                              ),
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              "Don't have an account? Sign up",
                              style: TextStyle(
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