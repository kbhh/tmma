import 'package:DW/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:DW/src/models/Post.dart';

class PostsBloc {
  final _repository = Repository();
  final _posts = PublishSubject<List<Post>>();

  Observable<List<Post>> get posts => _posts.stream;

  fetchPosts(catagory, pages) async {
    try {
      final posts = await _repository.fetchPosts(catagory, pages);
      _posts.sink.add(posts);
    } catch (err) {
      _posts.sink.addError(err);
    }
  }

  dispose() {
    _posts.close();
  }
}
