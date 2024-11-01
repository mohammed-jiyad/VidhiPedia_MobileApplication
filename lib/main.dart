import 'package:flutter/material.dart';
import 'package:vidhipedia/Login/Loginpage.dart';
import 'package:vidhipedia/MongoDB/mongodb.dart';

import 'package:vidhipedia/splash_screen.dart';
import 'package:vidhipedia/Kid/kidshomepage.dart';
import 'package:vidhipedia/Teen/teenhomepage.dart';
import 'package:vidhipedia/Adult/adulthomepage.dart';
import 'package:vidhipedia/Adult/Adultforum.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidhiPedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool visible = false;
  double myOpacity = 0.0;
  double menuPosition = -300;
  String? email;
  var arr = [
    'assets/images/kid.png',
    'assets/images/teen.png',
    'assets/images/adult.png'
  ];
  var label=['Kid','Teen','Adult'];

  var Name='';

  void onSelectButton2() {
    print("Button 2 pressed");
  }

  void onSelectButton3() {
    print("Button 3 pressed");
  }
  Future<void> _initializePath(int pathValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pathh', pathValue);
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    email=logindata.getString('email');
    print("Retrieved email: $email");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 40,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar with Title and Logo
                  Container(
                    width: double.infinity,
                    height: 90,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15))
                          ,color: Colors.orange,
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


                  // Learning Path Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    child: Text(
                      'Choose your Learning Path',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // List of Options
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: arr.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 300,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(label[index],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.asset(
                                arr[index],
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Button Section
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (index == 0) {
                                    await _initializePath(0);
                                    await MongoDatabase.addFieldToUser(email, 0);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => KidsHomePage()));

                                  } else if (index == 1) {
                                    await _initializePath(1);
                                    await MongoDatabase.addFieldToUser(email, 1);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TeenHomePage()));

                                  } else if (index == 2) {
                                    await _initializePath(2);
                                    await MongoDatabase.addFieldToUser(email, 2);
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AdultHomePage()));

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 15.0),
                                  backgroundColor:  Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: Text(
                                  'Select',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
