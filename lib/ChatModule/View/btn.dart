import 'package:chatapp/ChatModule/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



class Btn extends StatelessWidget {

  String txt;
  VoidCallback callback;
   Btn({Key? key,required this.txt,required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      child: MaterialButton(
        child: Text(
          txt, style: TextStyle(
          fontSize: 15
          ,color:  Colors.white,
          fontWeight: FontWeight.bold,
        )),
        onPressed: () {
          callback();


        },
        color: kPurpleColor ,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
