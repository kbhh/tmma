import 'dart:convert';

class Post {
  final int postId;
  final String postTitle;
  final String postDate;
  final String postModified;
  final String postStatus;
  final String postContent;
  final String postExcerpt;
  final ImageModel postFeaturedMedia;
  final Categories postCatagories;
  final int postAuthor;

  Post(
      {this.postId,
      this.postAuthor,
      this.postCatagories,
      this.postContent,
      this.postDate,
      this.postExcerpt,
      this.postFeaturedMedia,
      this.postModified,
      this.postStatus,
      this.postTitle});

  factory Post.fromJson(Map<String, dynamic> parsedJson) => Post(
      postId: parsedJson['id'],
      postTitle: parsedJson['title']['rendered'],
      postDate: parsedJson['date'],
      postModified: parsedJson['modified'],
      postStatus: parsedJson['status'],
      postContent: parsedJson['content']['rendered'],
      postFeaturedMedia: (parsedJson['featured_media']) > 0 &&
              (parsedJson['featured_media'] != null)
          ? ImageModel.fromJson(parsedJson['_embedded']['wp:featuredmedia'][0])
          : null,
      postCatagories:
          Categories.fromJson(parsedJson['_embedded']['wp:term'][0]),
      postExcerpt: parsedJson['excerpt']['rendered'],
      postAuthor: parsedJson['author']);

  Post.fromDb(Map<String, dynamic> parsedJson)
      : postId = parsedJson['id'],
        postTitle = parsedJson['title'],
        postDate = parsedJson['date'],
        postModified = parsedJson['modified'],
        postStatus = parsedJson['status'],
        postContent = parsedJson['content'],
        postFeaturedMedia = ImageModel.fromJson(parsedJson['_embedded']),
        postCatagories = parsedJson['categories'],
        postExcerpt = parsedJson['excrept'],
        postAuthor = parsedJson['author'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": postId,
      "author": postAuthor,
      "title": postTitle,
      "content": postContent,
      "excrept": postExcerpt,
      "date": postDate,
      // "catagories": jsonDecode(postCatagories.cats),
      "status": postStatus,
      "featured_media": postFeaturedMedia.thumbnail
    };
  }
}

class Categories {
  List<String> cats;

  Categories({this.cats});

  Categories.fromJson(List<dynamic> json) {
    cats = json.length > 0
        ? json.map((term) => term['name']).toList().cast<String>()
        : [];
  }
}

class ImageModel {
  final String thumbnail;
  final String large;

  ImageModel({this.thumbnail, this.large});

  factory ImageModel.fromJson(Map<String, dynamic> parsedJson) => ImageModel(
        thumbnail: parsedJson['media_details']['sizes']['medium'] != null
            ? parsedJson['media_details']['sizes']['medium']['source_url']
            : null,
        large: parsedJson['media_details']['sizes']['large'] != null
            ? parsedJson['media_details']['sizes']['large']['source_url']
            : null,
      );
}
