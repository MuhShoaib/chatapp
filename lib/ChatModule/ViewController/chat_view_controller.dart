import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Services/google_signin_service.dart';
import '../ViewModel/chat_view_model.dart';
import '../utils/constants.dart';

class ChatScreenViewController extends StatefulWidget {
  final String userEmail;

  ChatScreenViewController({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _ChatScreenViewControllerState createState() =>
      _ChatScreenViewControllerState();
}

class _ChatScreenViewControllerState extends State<ChatScreenViewController> {
  final googleLoginVM = GoogleLoginService();
  final chatVM = ChatViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatVM.getMessages(userEmail: widget.userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kPurpleColor,
          title: Text(widget.userEmail),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Obx(() => Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: chatVM.messages.value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    chatVM.messages.value[index].email ==
                                            widget.userEmail
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        // color: Color(0xfff6d365),
                                        color: chatVM.messages.value[index]
                                                    .email !=
                                                widget.userEmail
                                            ? kPurpleColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                "${chatVM.messages[index].text}\n",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                            children: <TextSpan>[
                                              TextSpan(

                                                  // DateFormat.EEEE().add_jm().format(DateTime.fromMillisecondsSinceEpoch(chatVM.messages[index].createdOn)).toUpperCase()
                                                  text:
                                                      "${DateFormat.MMM().add_Hm().format(DateTime.fromMillisecondsSinceEpoch(chatVM.messages[index].createdOn))}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12))
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //
                          );
                        },
                      ),
                    )),
                SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: chatVM.textController.value,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: kPurpleColor, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Type in your text",
                              fillColor: Colors.white70),
                        ),
                      )),
                      IconButton(
                          onPressed: () async {
                            if (chatVM.textController.value.text.isNotEmpty) {
                              await chatVM.sendMessage(
                                  context: context,
                                  userEmail: widget.userEmail);
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: kPurpleColor,
                          )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
