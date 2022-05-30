import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../Model/message_model.dart';
import '../Services/get_stoarage_handler.dart';

class ChatViewModel extends GetxController {
  Rx<TextEditingController> textController = TextEditingController().obs;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  getMessages({required String userEmail}) async {
    final userID = await GetStorageHandler().getEmail();
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot = FirebaseFirestore
        .instance
        .collection("users")
        .doc(userID)
        .collection("myusers")
        .doc(userEmail)
        .collection("messages")
        .orderBy("createdOn",descending: true)
        .snapshots();
    snapshot.listen((event) {
      if (MessageModel.firebaseTOMessageModelList(
        event.docs,
      ).isNotEmpty)
        messages.value = MessageModel.firebaseTOMessageModelList(event.docs);
    });
  }

  sendMessage({required BuildContext context, required String userEmail}) async {
    final myID = await GetStorageHandler().getEmail();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(myID)
        .collection("myusers")
        .doc(userEmail)
        .collection("messages")
        .doc()
        .set({
      "text": textController.value.text,
      "createdOn": DateTime.now().millisecondsSinceEpoch,
      "email": myID,
    });

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("myusers")
        .doc(myID)
        .collection("messages")
        .doc()
        .set({
      "text": textController.value.text,
      "createdOn": DateTime.now().millisecondsSinceEpoch,
      "email": myID,
    });
    textController.value.clear();
  }
}