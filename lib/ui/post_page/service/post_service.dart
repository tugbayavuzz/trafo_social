import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_blog/core/base/service/database_service.dart';
import 'package:travel_blog/ui/home/model/post_model.dart';

class PostService {
  PostModel _postFromFirebasePost(String uid) {
    return PostModel(uid: uid);
  }

  Future post(String sharedDate, String sharedImgUrl, String sharedLat,
      String sharedLong, String sharedText) async {
    try {
      String uid = FirebaseAuth.instance.currentUser.uid;
      DatabaseService(uid: uid).updatePost(
          sharedDate, sharedImgUrl, sharedLat, sharedLong, sharedText);
      return _postFromFirebasePost(uid);
    } catch (e) {}
  }
}
