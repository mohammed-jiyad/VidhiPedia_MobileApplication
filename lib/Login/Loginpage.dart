import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidhipedia/Adult/adulthomepage.dart';
import 'package:vidhipedia/Kid/kidshomepage.dart';
import 'dart:async';
import 'dart:math';
import 'package:vidhipedia/Login/CreateAccount.dart';
import 'package:vidhipedia/Teen/teenhomepage.dart';
import 'package:vidhipedia/main.dart';
import 'package:vidhipedia/MongoDB/mongodb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreen();
  }
}

class LoginScreen extends State<Loginpage> {
  bool bigCont = true;

  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _captchaController = TextEditingController();
  bool _isPasswordVisible = false;

  int _num1 = 0;
  int _num2 = 0;
  late int _captchaAnswer;
  bool _isCaptchaVerified = false;

  // Variables to store the email and password for later access
  String? _storedEmail;
  String? _storedPassword;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        bigCont = false;
      });
    });
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

  // Attempt to log in
  void _attemptLogin() async {
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) { // Validate the form
      if (_isCaptchaVerified) {
        final email = _emailController.text;
        final password = _passwordController.text;

        // Query MongoDB to check for matching email and password
        final user = await MongoDatabase.findUser(
          email,
          password, // Note: storing passwords in plaintext is discouraged; consider hashing in production
        );

        if (user != null ) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Login successful!"), duration: Duration(milliseconds: 500)),
          );
          int studypath = user['studypath'];
          logindata.setInt('login',1);
          logindata.setString('email', email);
          if(studypath==0) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => KidsHomePage()));
          }
          else if(studypath==1) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TeenHomePage()));
          }
          else if(studypath==2) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdultHomePage()));
          }
          else{
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage()));
          }


          // Navigate to the next screen or perform additional actions
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid email or password."), duration: Duration(milliseconds: 500)),
          );
          _validateCaptcha();
          _generateCaptcha();
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
      body: Column(
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 100, bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow:[BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color with opacity
                    blurRadius: 10.0, // Spread of the shadow
                    offset: Offset(0, 5), // Position of the shadow
                  ),] ,
                ),
                width: 350,

                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey, // Form key
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 40),
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
                                _generateCaptcha();
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 40),
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
                        // CAPTCHA Field with Background and Regenerate Option
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300, // CAPTCHA background
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
                                  child: TextFormField(
                                    controller: _captchaController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Answer',
                                    ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Captcha';
                                        }
                                        return null;
                                      }
                                  ),
                                ),

                              ),
                              ElevatedButton(
                                onPressed: _validateCaptcha,
                                child: Text("Verify"),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _generateCaptcha,
                              child: Text(
                                "Regenerate CAPTCHA",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Login Button
                        Center(
                          child: ElevatedButton(
                            onPressed: _attemptLogin,
                            child: Text("Login"),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => createacc()));
                            },
                            child: Text("Create Account"),
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
