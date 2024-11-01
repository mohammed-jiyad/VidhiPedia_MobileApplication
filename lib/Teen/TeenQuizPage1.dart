import 'package:flutter/material.dart';
import 'package:vidhipedia/Adult/AdultGamePage.dart';
import 'dart:async';
import 'package:vidhipedia/Teen/TeenForum.dart';
import 'package:vidhipedia/Teen/TeenLeaderboard.dart';

class TeenQuizPage1 extends StatefulWidget {
  @override
  State<TeenQuizPage1> createState() => TeenQuizPage1Screen();
}

class TeenQuizPage1Screen extends State<TeenQuizPage1> {
  int currentQuestionIndex = 0; // Tracks the current question
  int score = 0; // Tracks the score
  bool bigCont = true;
  bool cont = false;
  var selectedOptionIndex; // Track the selected option for the current question
  String feedbackMessage = ''; // Store the feedback message
  Color feedbackColor = Colors.transparent; // Color for feedback message background

  // Example question list
  List<String> question = ['What is your name?', 'What is your favorite color?'];

  // Correct: List<List<String>> for options, with each inner list containing 4 options
  List<List<String>> option = [
    ['Jiyad', 'Raj', 'Rahul', 'Okkk'], // Options for question 1
    ['Red', 'Blue', 'Green', 'Yellow'] // Options for question 2
  ];

  // Indices of the correct answers for each question
  List<int> correctAnswers = [0, 1];

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        bigCont = false;
      });
    });
  }

  void submitAnswer() {
    // Check if the selected option is correct
    bool isCorrect = selectedOptionIndex == correctAnswers[currentQuestionIndex];

    setState(() {

      if (isCorrect) {
        feedbackMessage = 'Correct! Well done.';
        feedbackColor = Colors.green;
        score++; // Increase score for correct answer
      } else {
        feedbackMessage =
        'Wrong! The correct answer is: ${option[currentQuestionIndex][correctAnswers[currentQuestionIndex]]}';
        feedbackColor = Colors.red;
      }

      // Move to the next question after a short delay
      Future.delayed(Duration(seconds: 1), () {
        if (currentQuestionIndex < question.length - 1) {
          setState(() {
            currentQuestionIndex++;
            selectedOptionIndex = null; // Reset selected option for the next question
            feedbackMessage = ''; // Reset feedback
            feedbackColor = Colors.transparent; // Reset background color
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Quiz Completed'),
              content: Text('Your score is $score/${question.length}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();// Dismiss the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ); // Quiz is finished, show final score
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView( // Added to make the content scrollable
        child: Column(
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
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              cont = !cont;
                            });
                          },
                          child: Image.asset(
                            'assets/images/teen.png',
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
            // Question and Options
            SizedBox(height: 100),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${currentQuestionIndex + 1})  ${question[currentQuestionIndex]}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Display options using RadioListTile
                        for (int i = 0; i < option[currentQuestionIndex].length; i++) // Accessing the correct options list
                          RadioListTile<int>(
                            title: Text(
                              option[currentQuestionIndex][i],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            value: i,
                            groupValue: selectedOptionIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedOptionIndex = value;
                              });
                            },
                            activeColor: Colors.orange,
                          ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: selectedOptionIndex != null
                        ? submitAnswer
                        : null, // Disable the button if no option is selected
                    child: Text(currentQuestionIndex < question.length - 1 ? 'Next' : 'Submit'),
                  ),
                  // Feedback Container
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: feedbackColor,
                    child: Text(
                      feedbackMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the buttons
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.orange,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
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
                    const SizedBox(height: 5),
                    const Text(
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
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.sports_esports,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'VidhiGames',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const Column(
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
    );
  }
}
