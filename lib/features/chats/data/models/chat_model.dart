import 'dart:convert';
import 'package:chaty/features/chats/data/models/message.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatModel {
  String? id;
  List<dynamic>? participants;
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
      'messages': messages,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      participants: map['participants'] != null
          ? List<dynamic>.from((map['participants'] as List<dynamic>))
          : null,
      messages: map['messages'] != null
          ? List<MessageModel>.from(
              (map['messages'] as List<dynamic>).map<MessageModel?>(
                (msg) => MessageModel.fromMap(msg as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
