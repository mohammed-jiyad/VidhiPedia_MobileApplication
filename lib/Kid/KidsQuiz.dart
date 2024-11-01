import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidhipedia/Kid/KidsLeaderboard.dart';
import 'dart:async';
import 'package:vidhipedia/Kid/KidsQuizPage1.dart';

class KidsQuiz extends StatefulWidget {
  @override
  State<KidsQuiz> createState() => KidsQuizScreen();
}

class KidsQuizScreen extends State<KidsQuiz> with SingleTickerProviderStateMixin {
  bool bigCont = true;
  bool cont = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> arr = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
    'Quiz 4'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

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
      ),
      body: Container(
        height: double.infinity,
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
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
                                  PopupMenuButton<String>(
                                    icon: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        'assets/images/kid.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'changePath',
                                          child: Text('Change Path'),
                                        ),
                                        PopupMenuItem(
                                          value: 'logout',
                                          child: Text('Logout'),
                                        ),
                                      ];
                                    },
                                    onSelected: (String value) {
                                      if (value == 'changePath') {
                                        // Implement Change Path functionality here
                                      } else if (value == 'logout') {
                                        // Implement Logout functionality here
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
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
                          child: TextButton(
                            onPressed: () {
                              if (index == 0) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => KidsQuizPage1(),
                                  ),
                                );
                              }
                              // Add navigation for other quizzes if needed
                            },
                            child: Text(
                              arr[index],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildBottomNavItem(
                          icon: Icons.sports_esports,
                          label: 'VidhiGames',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        _buildBottomNavItem(
                          icon: Icons.menu_book_rounded,
                          label: 'VidhiLearn',
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        _buildBottomNavItem(
                          icon: Icons.leaderboard,
                          label: 'Leaderboard',
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => KidsLeaderboardPage(),
                              ),
                            );
                          },
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

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.orange,
          child: InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
