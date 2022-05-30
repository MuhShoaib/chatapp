
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Services/get_stoarage_handler.dart';

class UsersViewModel extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  RxList<String> users = <String>[].obs;

  fetchAllUsers() async {
    final userID = await GetStorageHandler().getEmail();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection("users")
        .doc(userID)
        .collection("myusers")
        .snapshots();
    snapshot.listen((event) {
      users.value = event.docs.map((e) => "${e["email"]}").toList();
    });
  }
}