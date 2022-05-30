import 'package:chatapp/ChatModule/Model/user_model.dart';
import 'package:chatapp/ChatModule/Services/show_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'get_stoarage_handler.dart';


class ChatServices extends GetxController {

  saveUserInfo({required UserModel userModel}) async {
    await FirebaseFirestore.instance.collection("users").doc(userModel.email).set({
      "email":userModel.email,
      "url":userModel.url,
      "name":userModel.name
    });
  }

}



addUserService({required String email, required BuildContext context}) async {
  DocumentSnapshot snapshot =
  await FirebaseFirestore.instance.collection("users").doc(email).get();
  if (snapshot.exists) {
    final userEmail = await GetStorageHandler().getEmail();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(userEmail)
        .collection("myusers")
        .doc(email)
        .set({
      "email": email,
    });

        // SetOptions(merge: true));

    await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("myusers")
        .doc(userEmail)
        .set({
      "email": userEmail,
    });
    ShowMessage().showMessage(context, "User Added Successfully");
  } else {
    ShowMessage().showErrorMessage(context, "User Not Found");
  }
}
