import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhipedia/Adult/adulthomepage.dart';
import 'package:vidhipedia/Kid/kidshomepage.dart';
import 'package:vidhipedia/Login/Loginpage.dart';
import 'package:vidhipedia/Teen/teenhomepage.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? value;
  int? paths;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    final SharedPreferences path = await SharedPreferences.getInstance();

    value = logindata.getInt('login');
    paths= path.getInt('pathh');
    Timer(Duration(seconds: 2), () {
      if (value == 1 && paths==0) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => KidsHomePage()));
      }
      else if(value == 1 && paths==1){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TeenHomePage()));
      }
      else if(value == 1 && paths==2){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => AdultHomePage()));
      }
      else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Loginpage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orange,
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Image.asset('assets/images/cropped_image.png'),
            ),
          ),
        ),
      ),
    );
  }
}
