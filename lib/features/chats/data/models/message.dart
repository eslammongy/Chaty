import 'dart:convert';

enum MsgType { text, image }

class MessageModel {
  final String? text;
  final String? senderId;
  final DateTime? dateTime;
  final String? msgType;

  MessageModel({
    this.text,
    this.senderId,
    this.msgType,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'senderId': senderId,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'msgType': msgType ?? MsgType.text.name,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] != null ? map['text'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int)
          : null,
      msgType: map['msgType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
