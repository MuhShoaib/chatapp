import 'dart:async';

import 'package:chatapp/ChatModule/ViewController/users_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Services/get_stoarage_handler.dart';
import '../utils/constants.dart';
import 'google_login_view_controller.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkUser();
    });
  }

  checkUser() async {
    final email = await GetStorageHandler().getEmail();
    if (email != null) {
      Get.offAll(() => UsersViewController(email: email));
    } else {
      Get.offAll(() => GoogleAuthViewController());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double widthValue = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Container(
              width: widthValue,
              height: widthValue,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/chat.png"),
                ),
              ),
            ),
            Spacer(),
            Text(
              "Instant Messaging,\nSimple  And Personal",
              style: whiteTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "start your new journey in the Chat Us",
              style: greyTextStyle,
            ),
            SizedBox(height: 25),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
