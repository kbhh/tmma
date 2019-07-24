import 'dart:convert';
import 'package:DW/src/models/Video.dart';
import 'package:http/http.dart' show Client;

final key = "AIzaSyDM78CQgP4kprm2s770IJo4sg9CmVK4fV8";
final root =
    "https://www.googleapis.com/youtube/v3/search?key=$key&part=snippet";

class YoutubeApiProvider {
  Client client = Client();

  Future<List<Video>> fetchVideosOf(
    String channelId,
    String query,
    int maxResult,
  ) async {
    //
    try {
      final response = await client
          .get("$root&channelId=$channelId&q=$query&maxResults=$maxResult");
      Map<String, dynamic> responseBody = json.decode(response.body);
      List<dynamic> iterablePosts = responseBody['items'];

      List<Video> videos =
          iterablePosts.map((model) => Video.fromJson(model)).toList();
      return videos;
    } catch (err) {
      throw Exception(err);
    }
  }

  //

  // Future<Video> fetchPost(int id) async {
  //   final response = await client.get("$root/posts/$id");
  //   final post = json.decode(response.body);

  //   return Video.fromJson(post);
  // }
}
