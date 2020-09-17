import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid; // User id
  DatabaseService({this.uid});

  // Collection References

  // User Collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

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
}
