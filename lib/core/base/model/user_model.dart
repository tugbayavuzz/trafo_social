import 'package:travel_blog/ui/home/model/post_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String title;
  final String birthday;
  final String gender;
  final String profileImgUrl;
  List<PostModel> posts;
  UserModel(
      {this.uid,
      this.name,
      this.title,
      this.birthday,
      this.gender,
      this.profileImgUrl});
}
