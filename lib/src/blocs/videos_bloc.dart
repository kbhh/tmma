import 'package:DW/src/resources/videos_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:DW/src/models/Video.dart';

class VideosBloc {
  final _repository = Repository();
  final _videos = PublishSubject<List<Video>>();

  Observable<List<Video>> get videos => _videos.stream;

  fetchVideos(String id, String query, int maxResults) async {
    try {
      final videos = await _repository.fetchVideos(id, query, maxResults);
      _videos.sink.add(videos);
    } catch (err) {
      _videos.sink.addError(err);
    }
  }

  dispose() {
    _videos.close();
  }
}
