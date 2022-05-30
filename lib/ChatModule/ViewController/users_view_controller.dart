import 'package:chatapp/ChatModule/ViewController/chat_view_controller.dart';
import 'package:chatapp/ChatModule/ViewController/google_login_view_controller.dart';

import 'package:chatapp/ChatModule/ViewModel/users_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../Services/get_stoarage_handler.dart';
import '../Services/google_signin_service.dart';
import '../View/add_user_view.dart';
import '../utils/constants.dart';

class UsersViewController extends StatefulWidget {
  final String? email;

  UsersViewController({Key? key, required this.email}) : super(key: key);

  @override
  _UsersViewControllerState createState() => _UsersViewControllerState();
}

class _UsersViewControllerState extends State<UsersViewController> {
  final googleLoginVM = GoogleLoginService();
  final inBoxVM = Get.put(UsersViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inBoxVM.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
        appBar: AppBar(
            backgroundColor: kPurpleColor,
            title: Text("Inbox"),
            actions: [
              InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    await GetStorageHandler().removeEmail();
                    Get.offAll(() => GoogleAuthViewController());
                  },
                  child: Center(child: Text("LogOut"))),
              SizedBox(
                width: 20,
              ),
            ]),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: kPurpleColor,
          onPressed: () {
            addUserModal(context);
          },
          label: Text("Add Users"),
          icon: Icon(Icons.person_add_alt),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Obx(() => ListView.builder(
                  itemCount: inBoxVM.users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => ChatScreenViewController(
                                userEmail: inBoxVM.users[index]));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Obx(
                              () => ListView.builder(
                                itemCount: inBoxVM.users.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => ChatScreenViewController(
                                            userEmail: inBoxVM
                                                .users.value[index]));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: kGreyColor,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                blurRadius: 1,
                                                spreadRadius: 1,
                                              )
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                      "https://picsum.photos/200/300"),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(inBoxVM.users[index],style: TextStyle(color: Colors.white,fontSize: 18),),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ));
                  },
                ))));
  }
}
