import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowMessage {
  showMessage(
    BuildContext context,
    String message,
  ) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    // return showToast(
    //   '$message',
    //   textStyle: const TextStyle(color: Colors.white),
    //   context: context,
    //   animation: StyledToastAnimation.slideFromTop,
    //   backgroundColor: AppColor.buttonPrimaryColor,
    //   dismissOtherToast: true,
    //   position: StyledToastPosition.top,
    // );
  }

  showErrorMessage(BuildContext context, String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    // return showToast(
    //   '$message',
    //   context: context,
    //   animation: StyledToastAnimation.slideFromTop,
    //   backgroundColor: Colors.red,
    //   dismissOtherToast: true,
    //   position: StyledToastPosition.top,
    // );
  }
}
