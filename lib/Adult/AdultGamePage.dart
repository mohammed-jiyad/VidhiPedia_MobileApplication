import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidhipedia/Adult/AdultQuiz.dart';
import 'dart:async';
import 'package:vidhipedia/Adult/AdultLeaderboard.dart';
import 'package:vidhipedia/Adult/Adultforum.dart';
import 'package:vidhipedia/Adult/adulthomepage.dart';

class AdultGamepage extends StatefulWidget {
  @override
  State<AdultGamepage> createState() => AdultGameScreen();
}

class AdultGameScreen extends State<AdultGamepage> with SingleTickerProviderStateMixin {
  bool bigCont = true;
  bool cont = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> arr = [
    'assets/images/quiz.png',
    'assets/images/story.png',
    'assets/images/adult.png', 'assets/images/draft.png'
  ];
  List<String> label = ['Quiz', 'Story', 'Hunt', 'Draft'];

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
        title: Text('VidhiGames'),
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
                  SizeTransition(
                    sizeFactor: _animation,
                    child: Container(
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
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    cont = !cont;
                                  });
                                },
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
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      spacing: 20.0, // Space between items horizontally
                      runSpacing: 20.0, // Space between rows
                      alignment: WrapAlignment.center,
                      children: List.generate(arr.length, (index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 250,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  label[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  arr[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Button Section
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0, bottom: 15.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (index == 0) {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdultQuiz()));
                                    }
                                    // Handle other indices as needed
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                                    backgroundColor: Colors.orange,
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
                      }),
                    ),
                  ),
                ],
              ),
            ),
            if (cont) // Show menu only when cont is true
              Positioned(
                top: 90, // Position below the AppBar
                right: 10, // Align to the right
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
                          // Handle Change Path tap
                        },
                      ),
                      Divider(color: Colors.white),
                      ListTile(
                        title: Text('Logout', style: TextStyle(color: Colors.white)),
                        onTap: () {
                          // Handle Logout tap
                        },
                      ),
                    ],
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // CircleAvatar for the button appearance
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.orange,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>AdultForumPage()));
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
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  size: 30,
                                  color: Colors.white,
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
                                onTap: () {},
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
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LeaderboardPage()));
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
