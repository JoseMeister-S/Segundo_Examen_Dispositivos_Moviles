import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SEGUNDO PARCIAL Programación Móvil UCB',
      home: PostListPage(), 
    );
  }
}

class PostListPage extends StatefulWidget {
  const PostListPage({Key? key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  Dio dio = Dio();

  List<dynamic> posts = []; 

  @override
  void initState() {
    super.initState();
    fetchPosts(); 
  }

  Future<void> fetchPosts() async {
    try {
      Response response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        posts = response.data; 
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
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
          return ListTile(
            title: Text('ID: ${posts[index]['id']} - ${posts[index]['title']}'),
            subtitle: Text(posts[index]['body']),
          );
        },
      ),
    );
  }
}