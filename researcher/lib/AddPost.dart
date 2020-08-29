import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import './StartPage.dart';

class AddPost extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController journalController = TextEditingController();
  TextEditingController researchqController = TextEditingController();
  TextEditingController methodController = TextEditingController();
  TextEditingController resultsController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController techniqController = TextEditingController();
  DatabaseReference mRootRef = FirebaseDatabase.instance.reference();
  FirebaseAuth mAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: tagsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tags',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: journalController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Journal Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: researchqController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Research Question',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: techniqController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Techniques',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: methodController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Methodology',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: resultsController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Results',
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  color: Colors.white,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('SUBMIT'),
                      onPressed: () {
                        DatabaseReference ref = mRootRef.child("Post");
                        String postid = ref.push().key;
                        List<String> comm = List<String>();
                        Map<String, dynamic> map = {
                          'title': titleController.text,
                          'journal': journalController.text,
                          'researchq': researchqController.text,
                          'method': methodController.text,
                          'results': resultsController.text,
                          'tags':tagsController.text,
                          'techniq':techniqController.text,
                          'userId': mAuth.currentUser.uid,
                          'postId': postid,
                          'comments':comm,
                        };

                        print("map created");
                        mRootRef.child("Posts").child(postid).set(map);
                        print("added");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StartPage()),
                        );
                      },
                    )
                ),
              ],

            ))
    );
  }

}