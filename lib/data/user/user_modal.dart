import 'package:cloud_firestore/cloud_firestore.dart';

class  UserModal{
  final String? username;
  final String? userage;
  final String? id;

  UserModal({this.username, this.userage,this.id});
  factory UserModal.fromSnapshot(DocumentSnapshot snap){
    var shanshot = snap.data() as Map<String ,dynamic>;
    return UserModal(username: shanshot['username'],userage: shanshot['userage'],
    id: shanshot["id"]);

  }
  Map<String ,dynamic>toJson()=>{
    "username":username,
    "userage":userage,
    "id":id
  };


}
