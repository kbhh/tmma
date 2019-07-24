import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/Post.dart';

class Repository {
  NewsApiProvider apiProvider = NewsApiProvider();
  //NewsDbProvider db = NewsDbProvider().init();

  Future<List> fetchPosts(catagory, pages) {
    return apiProvider.fetchPostOf(catagory, pages);
  }

  fetchPost(id) async {
    var post = await apiProvider.fetchPost(id);

    if (post != null) {
      return post;
    }
  }
}
