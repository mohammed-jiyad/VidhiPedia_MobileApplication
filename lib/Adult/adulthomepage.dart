import 'package:flutter/material.dart';
import 'package:vidhipedia/Login/Loginpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vidhipedia/Adult/AdultGamePage.dart';
import 'package:vidhipedia/Adult/AdultLeaderboard.dart';
import 'dart:async';
import 'package:vidhipedia/main.dart';
import 'package:vidhipedia/Adult/Adultforum.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AdultHomePage extends StatefulWidget {
  @override
  State<AdultHomePage> createState() => AdultHomeScreen();
}

class AdultHomeScreen extends State<AdultHomePage> {
  bool bigCont = true;
  late final WebViewController controller;
  Future<void> _SetLogin() async {
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    await logindata.setInt('login', 0);
  }
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        bigCont = false;
      });
    });
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://roadmap.sh/r/embed?id=66f3f101c45e253cb04d9e9d'));
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
          // Top orange bar with title and logo
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: double.infinity,
            height: bigCont ? 210 : 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.orange,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: PopupMenuButton<int>(elevation: 10,
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          } else if (value == 2) {
                            // Handle Logout action
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text('Change Path'),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text('Logout'),
                            onTap: (){
                              _SetLogin();
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Loginpage()));
                            },
                          ),
                        ],
                        child: Image.asset(
                          'assets/images/adult.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // WebView below the top bar and without overlapping
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
      // Bottom container stays fixed at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Material(
          elevation: 160,
          borderRadius: BorderRadius.all(Radius.circular(21)),
          color: Colors.grey.shade100,
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(21)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdultForumPage()));
                        },
                        child: Icon(
                          Icons.forum,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'VidhiForum',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'VidhiLearn',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdultGamepage()));
                        },
                        child: Icon(
                          Icons.sports_esports,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'VidhiGames',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.event,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'VidhiTime',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LeaderboardPage()));
                        },
                        child: Icon(
                          Icons.leaderboard,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Leaderboard',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}