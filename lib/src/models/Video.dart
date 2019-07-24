import 'dart:convert';

class Video {
  final String videoId;
  final String videoTitle;
  final String uploadDate;
  final String videoThumbnail;

  Video({this.videoId, this.uploadDate, this.videoThumbnail, this.videoTitle});

  factory Video.fromJson(Map<String, dynamic> parsedJson) => Video(
        videoId: parsedJson['id']['videoId'],
        videoTitle: parsedJson['snippet']['title'],
        uploadDate: parsedJson['snippet']['publishedAt'],
        videoThumbnail: parsedJson['snippet']['thumbnails']['high']['url'],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": videoId,
      "title": videoTitle,
      "date": uploadDate,
      "featured_media": videoThumbnail
    };
  }
}
