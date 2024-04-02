import 'package:examen/api_service.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SEGUNDO PARCIAL Programación Móvil UCB',
      home: PostListPage(), // Use PostListPage as the home page
    );
  }
}

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  final ApiService _apiService = ApiService(); // Create instance of ApiService

  List<dynamic> posts = []; // List to store posts

  @override
  void initState() {
    super.initState();
    fetchPosts(); // Call fetchPosts when the widget initializes
  }

  Future<void> fetchPosts() async {
    List<dynamic> fetchedPosts = await _apiService.fetchPosts();
    setState(() {
      posts = fetchedPosts; // Store the fetched posts
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${posts[index]['id']}', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(posts[index]['title'], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text(posts[index]['body']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}