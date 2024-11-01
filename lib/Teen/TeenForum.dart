import 'package:flutter/material.dart';
import 'package:vidhipedia/Teen/TeenGamePage.dart';
import 'package:vidhipedia/Teen/TeenLeaderboard.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:vidhipedia/Kid/KidsGamePage.dart';
import 'package:vidhipedia/Kid/KidsLeaderboard.dart';
import 'dart:async';
import 'package:vidhipedia/main.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;
  final List<String> comments;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.comments,
  });
}

List<Post> posts = [];

class TeenForumPage extends StatefulWidget {
  @override
  State<TeenForumPage> createState() => TeenForumScreen();
}

class TeenForumScreen extends State<TeenForumPage> {
  bool bigCont = true;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        bigCont = false;
      });
    });
  }

  void _addNewPost(Post post) {
    setState(() {
      posts.add(post);
    });
  }

  // Function to display the modal for adding a post
  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _titleController = TextEditingController();
        final TextEditingController _contentController = TextEditingController();

        return AlertDialog(
          title: Text('New Post'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Post Title'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(labelText: 'Post Content'),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newPost = Post(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  content: _contentController.text,
                  timestamp: DateTime.now(),
                  comments: [],
                );
                _addNewPost(newPost);
                Navigator.of(context).pop(); // Close the dialog after adding the post
              },
              child: Text('Add Post'),
            ),
          ],
        );
      },
    );
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
                      child: PopupMenuButton<int>(
                        elevation: 10,
                        onSelected: (value) {
                          if (value == 1) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
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
                          ),
                        ],
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
          // WebView below the top bar and without overlapping
          Expanded(
            child: posts.isEmpty
                ? Center(child: Text('No posts yet!'))
                : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100, // Light orange background
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].content),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostDetailPage(post: posts[index]),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddPostDialog, // Show dialog to add a post
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
                _buildBottomNavigationItem(Icons.forum, 'VidhiForum', Colors.orange),
                _buildBottomNavigationItem(Icons.menu_book_rounded, 'VidhiLearn', Colors.orange),
                _buildBottomNavigationItem(Icons.sports_esports, 'VidhiGames', Colors.orange, onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Gamepage()));
                }),
                _buildBottomNavigationItem(Icons.event, 'VidhiTime', Colors.orange),
                _buildBottomNavigationItem(Icons.leaderboard, 'Leaderboard', Colors.orange, onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeenLeaderboardPage()));
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: color,
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
            color: color,
          ),
        ),
      ],
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final Post post;
  PostDetailPage({required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    setState(() {
      widget.post.comments.add(_commentController.text);
    });
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.content,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            widget.post.comments.isEmpty
                ? Text('No comments yet!')
                : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.post.comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.post.comments[index]),
                );
              },
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Add a comment'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addComment,
              child: Text('Submit Comment'),
            ),
          ],
        ),
      ),
    );
  }
}
