import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<dynamic>> fetchPosts() async {
    try {
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      return response.data;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }
}
