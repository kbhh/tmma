import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/Post.dart';

class NewsDbProvider {
  Database db;

  init() async {
    Directory documentDirectoryy = await getApplicationDocumentsDirectory();
    final path = join(documentDirectoryy.path, 'dw_db565.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
           CREATE TABLE posts (
            id INTEGER PRIMARY KEY,
            title TEXT,
            content TEXT, 
            excrept TEXT,
            date DATE,
            author TEXT, 
            catagories BLOB,
            status TEXT,
            featured_media TEXT,
           )
         """);

        newDb.execute("""
            CREATE TABLE fav_post{
              post_id INTEGER PRIMARY KEY,
              post_title TEXT,
              post_excrept TEXT,
              featured_media TEXT
            }
         """);
      },
    );
  }

  fetchPost(int id) async {
    final postMaps = await db.query(
      "dw_db565",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    //  if(postMaps.length > 0 ){
    //    return Post.fromDb(postMaps)
    //  }
    return null;
  }

  addPost(Post post) async {
    db.insert("dw_db565", post.toMap());
  }
}
