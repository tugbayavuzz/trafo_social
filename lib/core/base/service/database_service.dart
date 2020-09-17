import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_blog/core/base/model/user_model.dart';

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
      String gender, String profileImgUrl) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'title': title,
      'birthday': birthday,
      'gender': gender,
      'profileImgUrl': profileImgUrl
    });
  }

  Future updatePost(String sharedDate, List<String> sharedImgs,
      String sharedLat, String sharedLong, String sharedText) async {
    return await postCollection.doc(uid).set({
      'sharedDate': sharedDate,
      'sharedImgs': sharedImgs,
      'sharedLat': sharedLat,
      'sharedLong': sharedLong,
      'sharedText': sharedText
    });
  }

  // Get user list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
              name: doc.data()['name'] ?? '',
              title: doc.data()['title'] ?? '',
              birthday: doc.data()['birthday'] ?? '',
              gender: doc.data()['gender'] ?? '',
              profileImgUrl: doc.data()['profileImgUrl']) ??
          '';
    }).toList();
  }

  // Get Post Stream
  Stream<QuerySnapshot> get posts {
    return postCollection.snapshots();
  }
}
