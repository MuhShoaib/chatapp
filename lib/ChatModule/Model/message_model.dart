class MessageModel {
  String text;
  int createdOn;
  String email;

  MessageModel(
      {required this.text, required this.email, required this.createdOn});

  factory MessageModel.fromFirebase(dynamic json) => MessageModel(
    text: json.data()["text"],
    createdOn: json.data()["createdOn"],
    email: json.data()["email"],
  );

  static List<MessageModel> firebaseTOMessageModelList(
      dynamic emote,
      ) =>
      emote
          .map<MessageModel>((item) => MessageModel.fromFirebase(
        item,
      ))
          .toList();

  factory MessageModel.fromEmpty() => MessageModel(
    text: "",
    createdOn: 0,
    email: "",
  );
}