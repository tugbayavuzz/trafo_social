import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_blog/ui/home/model/post_model.dart';

class DatabaseService {
  final String uid; // User id
  DatabaseService({this.uid});

  // Collection References

  // User Collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Post Collection
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  // Updates

  Future updateUserData(String name, String title, String birthday,
      String gender, String profileImgUrl, List<PostModel> posts) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'title': title,
      'birthday': birthday,
      'gender': gender,
      'profileImgUrl': profileImgUrl,
      'posts': posts
    });
  }

  Future updatePost(String sharedDate, String sharedImgUrl, String sharedLat,
      String sharedLong, String sharedText) async {
    return await postCollection.doc(uid).set({
      'sharedDate': sharedDate,
      'sharedImgs': sharedImgUrl,
      'sharedLat': sharedLat,
      'sharedLong': sharedLong,
      'sharedText': sharedText
    });
  }

  // Get user list from snapshot
  List<PostModel> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
              sharedDate: doc.data()['sharedDate'] ?? '',
              sharedImg: doc.data()['sharedImgs'] ?? '',
              sharedLat: doc.data()['sharedLat'] ?? '',
              sharedLong: doc.data()['sharedLong'] ?? '',
              sharedText: doc.data()['sharedText']) ??
          '';
    }).toList();
  }

  // Get Post Stream
  Stream<List<PostModel>> get posts {
    return postCollection.snapshots().map(_postListFromSnapshot);
  }
}
