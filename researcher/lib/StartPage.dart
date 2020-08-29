import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:researcher/AddPost.dart';
import 'package:researcher/Post.dart';


class StartPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<StartPage> {

  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference mRootRef = FirebaseDatabase.instance.reference();

  Future<List<Post>> getPosts() async {
    List<Post> posts = new List<Post>();

    await mRootRef
        .child('Posts')
        .once()
        .then((DataSnapshot dataSnapshot) {
      Map<dynamic, dynamic> data = dataSnapshot.value;
      data.forEach((key, value) {
        posts.add(Post.mapToPostData(value));
      });
      print('PostList : $posts');
    });
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: FutureBuilder(
                        future: getPosts(),
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.none: return new Text('Press button to start');
                            case ConnectionState.waiting: return new Text('Loading..');
                            default:
                              if(snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              else
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context,index){
                                    return Card(
                                      child: ListTile(
                                        title: Text(snapshot.data[index].title),
                                        trailing: Icon(Icons.keyboard_arrow_right),
                                        onTap: () { //                                  <-- onTap
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => PostView(snapshot.data[index])),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                          }
                        }),
                  ),
                ),
              ],
            )
        ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPost()),
        );
      },
      tooltip: 'Add Paper',
      child: Icon(Icons.add),
    ),
    );
  }

}

class PostView extends StatelessWidget{
  Post item;
  PostView(Post item){
    this.item = item;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostViewHome(item),
    );
  }
}
class PostViewHome extends StatefulWidget{
  Post item;
  PostViewHome(Post item){
    this.item = item;
  }
  @override
  _PostViewHomeState createState() => _PostViewHomeState(item);
}

class _PostViewHomeState extends State<PostViewHome> {
  Post item;
  final DatabaseReference mRootRef = FirebaseDatabase.instance.reference();
  List<String> comments = List<String>();
  final TextEditingController commentController = TextEditingController();
  _PostViewHomeState(Post item){
    this.item = item;
  }


  Future<List<String>> getComments() async {
     await mRootRef
        .child('Comments')
        .child(item.postId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      List<dynamic> data = dataSnapshot.value;
      data.forEach((value) {
        print(value.toString());
        comments.add(value.toString());
      });
      print('CommentsList : $comments');
    });
     return comments;
  }
  @override
  Widget build(BuildContext context) {
//    getComments();
    print(comments.length);
//    getComments();

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 2,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Tags",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.tags,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Journal",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.journal,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Research Question",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.researchq,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Techniques",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.techniq,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Methodology",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.method,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Results",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.results,
                    textAlign: TextAlign.left,
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Comments: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: FutureBuilder(
                        future: getComments(),
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.none: return new Text('Press button to start');
                            case ConnectionState.waiting: return new Text('Loading..');
                            default:
                              if(snapshot.hasError)
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'No comments yet.',
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1,
                                  ),
                                );
                              else
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context,index){
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        snapshot.data[index],
                                        textAlign: TextAlign.left,
                                        textScaleFactor: 1,
                                      ),
                                    );
                                  },
                                );
                          }
                        }),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 220,
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Add Comment',
                        ),
                      ),
                    ),
                    Container(
                        width: 100,
                        height: 50,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: Text('Comment'),
                          onPressed: () {
//                            print("pressed");
                            DatabaseReference ref = mRootRef.child("Comments");
                            comments.add(commentController.text);
                            print("map created");
                            mRootRef.child("Comments").child(item.postId).set(comments);
                            print("added");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PostView(item)),
                                  );
                          },
                        )
                    ),
                  ],
                )
              ],
            )
        )
    );

  }
}

