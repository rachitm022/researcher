import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './StartPage.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
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
              child: Text('Login'),
              onPressed: () {
                mAuth.signInWithEmailAndPassword(email: nameController.text, password: passwordController.text);
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