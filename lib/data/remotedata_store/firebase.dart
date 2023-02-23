import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/data/user/user_modal.dart';

class FirebaseHelper {
  static Stream<List<UserModal>> red() {
    final userCollection = FirebaseFirestore.instance.collection("Users");

    return userCollection
        .snapshots()
        .map((qss) => qss.docs.map((e) => UserModal.fromSnapshot(e)).toList());
  }

  // for show data
  static Future create(UserModal user) async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    // final docRef = userCollection.doc('user-id');
    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newUser =
        UserModal(id: uid, username: user.username, userage: user.userage)
            .toJson();
    try {
      await docRef.set(newUser);
    } catch (e) {
      print("some error");
    }
  }



  static Future update(UserModal user) async {
    final userCollection = FirebaseFirestore.instance.collection("Users");
    // final docRef = userCollection.doc('user-id');

    final docRef = userCollection.doc(user.id);

    final newUser =
    UserModal(id: user.id, username: user.username, userage: user.userage)
        .toJson();
    try {
      await docRef.update(newUser);
    } catch (e) {
      print("some error");
    }
  }


  static Future delete(UserModal user)async{

    final userCollection = FirebaseFirestore.instance.collection("Users");
    userCollection.doc(user.id).delete();

  }
}


