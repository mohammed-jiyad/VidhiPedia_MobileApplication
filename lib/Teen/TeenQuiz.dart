import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:vidhipedia/Teen/TeenForum.dart';
import 'package:vidhipedia/Teen/TeenGamePage.dart';
import 'package:vidhipedia/Teen/TeenLeaderboard.dart';
import 'package:vidhipedia/Teen/TeenQuizPage1.dart';

class TeenQuiz extends StatefulWidget {
  @override
  State<TeenQuiz> createState() => TeenQuizScreen();
}

class TeenQuizScreen extends State<TeenQuiz> with SingleTickerProviderStateMixin {
  bool bigCont = true;
  bool cont = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> arr = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3','Quiz 4'
  ];


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800), vsync: this,

    );

    // Define the animation with a bouncing curve
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    // Start the animation after a delay
    Timer(Duration(milliseconds: 300), () {
      _controller.forward();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 40,
        title: Text('VidhiQuiz'),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top orange bar with title and logo
                  Column(
                    children: [
                      SizeTransition(
                        sizeFactor: _animation,
                        child: Container(
                          width: double.infinity,
                          height:90,
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
                                    child: Image.asset(
                                      'assets/images/teen.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (cont) // Show menu only when cont is true
                        Align(
                          alignment: Alignment.topRight, // Align to the right
                          child: Container(
                            height: 150,
                            width: 150,
                            margin: EdgeInsets.only(top: 10), // Adjust the vertical position
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                ListTile(
                                  title: Text('Change Path', style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle menu item 2 tap
                                  },
                                ),
                                Divider(color: Colors.white),
                                ListTile(
                                  title: Text('Logout', style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle menu item 3 tap
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      spacing: 20.0, // Space between items horizontally
                      runSpacing: 20.0, // Space between rows
                      alignment: WrapAlignment.center,
                      children: List.generate(arr.length, (index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
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


                              // Button Section
                              TextButton(
                                onPressed: () {
                                  if (index == 0) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeenQuizPage1()));

                                  } else if (index == 1) {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TeenHomePage()));

                                  } else if (index == 2) {
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdultHomePage()));

                                  }
                                  else if(index==3){
                                    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdultHomePage()));
                                  }
                                },

                                child: Text(
                                  arr[index],
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the buttons
                      children: [
                        // CircleAvatar for the button appearance
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32, // Increased size
                              backgroundColor: Colors.orange, // Background color of the CircleAvatar
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TeenForumPage()));
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
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
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
                                onTap: (){
                                  Navigator.of(context).pop();
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
                                onTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TeenLeaderboardPage()));
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
            ),
          ],
        ),
      ),
    );
  }
}
