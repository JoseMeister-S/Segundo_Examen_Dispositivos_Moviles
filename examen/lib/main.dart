import 'package:examen/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final ApiService _apiService = ApiService();
  List<dynamic> posts = [];
  List<double> ratings = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await fetchPosts(); 
    await loadRatings(); 
  }

  Future<void> fetchPosts() async {
    List<dynamic> fetchedPosts = await _apiService.fetchPosts();
    setState(() {
      posts = fetchedPosts;
    });
  }

  Future<void> loadRatings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ratings = List<double>.generate(posts.length, (index) {
        return prefs.getDouble('rating_$index') ?? 3.0;
      });
    });
  }

  Future<void> saveRating(int index, double rating) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('rating_$index', rating); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts, Examen'),
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
                  Text('ID: ${posts[index]['id']}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(posts[index]['title'], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text(posts[index]['body']),
                  RatingBar.builder(
                    initialRating: ratings[index],
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        ratings[index] = rating;
                      });
                      saveRating(index, rating); // Save the updated rating
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
