import 'dart:convert';
import 'package:chaty/features/chats/data/models/message.dart';

class ChatModel {
  String? id;
  final List<dynamic>? participants;
  final List<MessageModel>? messages;
  bool isCreated = false;
  ChatModel({
    this.id,
    this.participants,
    this.messages,
    this.isCreated = false,
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
          ? List<dynamic>.from((map['participants'] as List<dynamic>))
          : null,
      messages: map['messages'] != null
          ? List<MessageModel>.from((map['messages'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
}
