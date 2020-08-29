import 'package:firebase_database/firebase_database.dart';


class Post {
  String postId;
  String userId;
  String title;
  String journal;
  String researchq;
  String method;
  String results;
  String tags;
  String techniq;

  Post({
    this.postId,
    this.userId,
    this.title,
    this.journal,
    this.researchq,
    this.method,
    this.results,
    this.tags,
    this.techniq,
  });

  Map<String, dynamic> PostDataToMap() {

    return <String, dynamic>{
      'postId': this.postId,
      'userId':this.userId,
      'title': this.title,
      'journal': this.journal,
      'researchq': this.researchq,
      'method': this.method,
      'results': this.results,
      'tags':this.tags,
      'techniq':this.techniq,
    };
  }

  Post.mapToPostData(Map<dynamic, dynamic> map) {
//    gallery = [];

    this.postId = map['postId'];
    this.userId = map['userId'];
    //this.gallery = map['gallery'] as List<String>;
    this.title = map['title'];
    this.journal = map['journal'];
    this.researchq = map['researchq'];
    this.method = map['method'];
    this.results = map['results'];
    this.tags = map['tags'];
    this.techniq = map['techniq'];
  }

}