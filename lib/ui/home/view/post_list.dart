import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_blog/ui/home/model/post_model.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<PostModel>>(context);
    posts.forEach((post) {
      print(post.sharedDate);
      print(post.sharedLat);
      print(post.sharedLong);
    });
    return Container();
  }
}
