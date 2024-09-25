import 'dart:convert';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/user/data/models/user_model.dart';

class ChatModel {
  String? id;
  final List<String>? participants;
  List<MessageModel>? messages;
  // this field represent the user that is not the current user using the app ot the device
  UserModel? currentRecipient;

  ChatModel({
    this.id,
    this.participants,
    this.messages,
    this.currentRecipient,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'participants': participants,
      'messages': messages
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      participants: map['participants'] != null
          ? List<String>.from((map['participants'] as List<dynamic>))
          : [],
      messages: map['messages'] != null
          ? List.from(map['messages'].map((msg) => MessageModel.fromMap(msg)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());
}
