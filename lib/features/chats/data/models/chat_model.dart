import 'dart:convert';
import 'package:chaty/features/chats/data/models/message.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatModel {
  String? id;
  List<String>? participants;
  List<MessageModel>? messages;
  ChatModel({
    this.id,
    this.participants,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'participants': participants,
      'messages': messages?.map((msg) => msg.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      participants: map['participants'] != null
          ? List<String>.from((map['participants'] as List<String>))
          : null,
      messages: map['messages'] != null
          ? List<MessageModel>.from(
              (map['messages'] as List<int>).map<MessageModel?>(
                (x) => MessageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
