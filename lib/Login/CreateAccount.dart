import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vidhipedia/MongoDB/mongodb.dart';
import 'package:vidhipedia/Login/Loginpage.dart';

class createacc extends StatefulWidget {
  @override
  State<createacc> createState() => createaccScreen();
}

class createaccScreen extends State<createacc> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  int _num1 = 0;
  int _num2 = 0;
  late int _captchaAnswer;
  bool _isCaptchaVerified = false;

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  // Generate a simple math CAPTCHA
  void _generateCaptcha() {
    final random = Random();
    _num1 = random.nextInt(10); // Random number between 0-9
    _num2 = random.nextInt(10);
    _captchaAnswer = _num1 + _num2;
    _captchaController.clear();
    setState(() {}); // Update UI with the new CAPTCHA
  }

  // Verify the CAPTCHA
  void _validateCaptcha() {
    if (int.tryParse(_captchaController.text) == _captchaAnswer) {
      setState(() {
        _isCaptchaVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CAPTCHA verified successfully!"), duration: Duration(milliseconds: 500)),
      );
    } else {
      setState(() {
        _isCaptchaVerified = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CAPTCHA verification failed. Try again."), duration: Duration(milliseconds: 500)),
      );
      _generateCaptcha();
    }
  }

  // Attempt to create an account
  void _attemptCreateAccount() async {
    if (_formKey.currentState!.validate()) {
      if (_isCaptchaVerified) {
        // Check if the email already exists
        bool emailExists = await MongoDatabase.emailExists(_emailController.text);
        if (emailExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An account with this email already exists."), duration: Duration(milliseconds: 500)),
          );
          return; // Exit the method if the email exists
        }

        final userData = {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          '_id': _emailController.text,
          'studypath': 99
        };

        try {
          await MongoDatabase.insertUser(userData);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account created successfully!"), duration: Duration(milliseconds: 500)),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Loginpage()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error creating account: ${e.toString()}"), duration: Duration(milliseconds: 500)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please verify the CAPTCHA to proceed."), duration: Duration(milliseconds: 500)),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Colors.orange,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'VidhiPedia',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                width: 350,

                child: Form(
                  key: _formKey, // Form key
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Field
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Email Field
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailPattern = r'\b[A-Za-z0-9._%+-]+@(gmail|yahoo|outlook|icloud)\.com\b';
                            if (!RegExp(emailPattern).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Password Field with Visibility Toggle
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Confirm Password Field with Visibility Toggle
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Confirm your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      // CAPTCHA Field with Regenerate Option
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Text(
                                "$_num1 + $_num2 = ?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: 80,
                                height: 40,
                                child: TextField(
                                  controller: _captchaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Answer',
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _generateCaptcha,
                              child: Text(
                                "Regenerate",
                                style: TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // CAPTCHA Validation Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: ElevatedButton(
                            onPressed: _validateCaptcha,
                            child: Text("Verify CAPTCHA"),
                            style: ElevatedButton.styleFrom(

                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                          ),
                        ),
                      ),
                      // Create Account Button
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                          child: ElevatedButton(
                            onPressed: _attemptCreateAccount,
                            child: Text("Create Account"),
                            style: ElevatedButton.styleFrom(

                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Loginpage()));
                          },
                          child: Text("Already have an Account?"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
