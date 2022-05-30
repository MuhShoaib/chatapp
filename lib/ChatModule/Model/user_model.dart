import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String email;
  String? url;

  UserModel({
    required this.email,this.name,this.url

  });

  factory UserModel.fromJson(DocumentSnapshot json) => UserModel(
        // fcm: (json.data() as dynamic)["fcm"] ?? "",
        name: (json.data() as dynamic)["name"] ?? "",
         email: (json.data() as dynamic)["email"] ?? "",
        url: (json.data() as dynamic)["url"] ?? "",
      );

  static List<UserModel> jsonToUserModelList(List<DocumentSnapshot> jsonList) =>
      jsonList.map<UserModel>((item) => UserModel.fromJson(item)).toList();
}
