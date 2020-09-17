import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<QuerySnapshot>(context);
    //print(posts.docs);
    for (var doc in posts.docs) {
      print(doc.data);
    }
    return Container();
  }
}
