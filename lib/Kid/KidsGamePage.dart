import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidhipedia/Kid/KidsLeaderboard.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhipedia/Kid/KidsQuiz.dart';
import 'package:vidhipedia/Login/Loginpage.dart';

class KidsGamepage extends StatefulWidget {
  @override
  State<KidsGamepage> createState() => KidsGameScreen();
}

class KidsGameScreen extends State<KidsGamepage> with SingleTickerProviderStateMixin {
  bool bigCont = true;
  bool cont = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  List<String> arr = [
    'assets/images/quiz.png',
    'assets/images/story.png',
    'assets/images/adult.png',
    'assets/images/draft.png'
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

  Future<void> _setLogin() async {
    final SharedPreferences logindata = await SharedPreferences.getInstance();
    await logindata.setInt('login', 0);
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    onSelected: (value) {
                                      if (value == 'Change Path') {
                                        // Handle Change Path action
                                      } else if (value == 'Logout') {
                                        _setLogin();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder: (context) => Loginpage()));
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'Change Path',
                                        child: Text('Change Path'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Logout',
                                        child: Text('Logout'),
                                      ),
                                    ],
                                    icon: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: Image.asset(
                                        'assets/images/kid.png',
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 15.0, right: 15.0, bottom: 15.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (index == 0) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => KidsQuiz()));
                                    }
                                    // Add other navigations as needed
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 10.0),
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
                              child: InkWell(
                                onTap: () {
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
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) => KidsLeaderboardPage()));
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
