import 'dart:async';
import 'package:TMMA/src/resources/youtube_api_provider.dart';
import 'package:TMMA/src/models/Video.dart';

class Repository {
  YoutubeApiProvider apiProvider = YoutubeApiProvider();
  //NewsDbProvider db = NewsDbProvider().init();

  Future<List> fetchVideos(
    String channelId,
    String query,
    int maxResult,
  ) {
    return apiProvider.fetchVideosOf(channelId, query, maxResult);
  }

  // fetchPost(id) async {
  //   var post = await apiProvider.fetchPost(id);

  //   if (post != null) {
  //     return post;
  //   }
  // }
}
