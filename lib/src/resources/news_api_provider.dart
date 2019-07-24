import 'dart:convert';
import '../models/Post.dart';
import 'package:http/http.dart' show Client;

final root = "https://www.dw.uffey.com/wp-json/wp/v2";

class NewsApiProvider {
  Client client = Client();

  Future<List<Post>> fetchPostOf(List<int> catagory, int pages) async {
    var catagoriesList = "";
    if (catagory.length > 0) {
      catagoriesList = catagory.join(',');
    }
    try {
      final response = await client
          .get("$root/posts?categories=$catagoriesList&per_page=$pages&_embed");
      List<dynamic> iterablePosts = json.decode(response.body);

      List<Post> posts =
          iterablePosts.map((model) => Post.fromJson(model)).toList();

      return posts;
    } catch (error) {
      throw Exception(error);
    }
  }

  //

  Future<Post> fetchPost(int id) async {
    final response = await client.get("$root/posts/$id");
    final post = json.decode(response.body);

    return Post.fromJson(post);
  }
}
