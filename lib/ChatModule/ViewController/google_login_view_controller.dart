import 'package:chatapp/ChatModule/Services/firebase_services.dart';
import 'package:chatapp/ChatModule/ViewController/users_view_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Model/user_model.dart';
import '../Services/get_stoarage_handler.dart';
import '../Services/google_signin_service.dart';
import '../View/btn.dart';
import '../utils/constants.dart';

class GoogleAuthViewController extends StatefulWidget {
  const GoogleAuthViewController({Key? key}) : super(key: key);

  @override
  State<GoogleAuthViewController> createState() =>
      _GoogleAuthViewControllerState();
}

class _GoogleAuthViewControllerState extends State<GoogleAuthViewController> {
  String name = "";
  String email = "";
  String url = "";
  final googleLoginVM = GoogleLoginService();


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,

        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(child: Image.asset("asset/chat.png", height: 200, width: 200)),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Register with Your Google Account",
                  style: whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Btn(
                  txt: "Google SignIn",
                  callback: () async {
                    UserCredential userCredential =
                        await googleLoginVM.onGoogleSignIn();
                    googleLoginVM.onGoogleLogout();

                    if (userCredential != null) {
                      await ChatServices().saveUserInfo(
                          userModel: UserModel(
                              email: userCredential.user!.email!,
                              url: userCredential.user!.photoURL!,
                              name: userCredential.user!.displayName!));
                      await GetStorageHandler()
                          .setEmail(userCredential.user!.email!);
                      Get.offAll(() => UsersViewController (email:userCredential.user!.email ));


                    }
                  },
                ),
              ),
            ],
          ),
        ),

    );
  }
}
