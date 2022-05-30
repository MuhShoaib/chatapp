import 'package:chatapp/ChatModule/Model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/firebase_services.dart';
import '../Services/show_message.dart';
import '../ViewModel/users_view_model.dart';
import '../utils/constants.dart';
import 'btn.dart';

addUserModal(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final usersVM = Get.put(UsersViewModel());
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: usersVM.emailController.value,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: kPurpleColor),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(color: kPurpleColor, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Add User",
                        ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Btn(

                    callback: () async {
                      if (usersVM.emailController.value.text.isNotEmpty) {
                        await addUserService(
                            context: context, email: usersVM.emailController.value.text );
                        Get.back();
                      } else {
                        ShowMessage().showErrorMessage(context, "Enter email");
                      }
                    }, txt: 'Add User',
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
