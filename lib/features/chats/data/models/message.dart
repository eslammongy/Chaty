import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MsgType { text, image, file }

class MessageModel {
  final String? text;
  final String? senderId;
  final Timestamp? dateTime;
  final MsgType msgType;

  MessageModel({
    this.text,
    this.senderId,
    this.msgType = MsgType.text,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'senderId': senderId,
      'dateTime': dateTime,
      'msgType': msgType.name,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'],
      senderId: map['senderId'],
      dateTime: map['dateTime'],
      msgType: MsgType.values.byName(map['msgType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.buildMsg(
    String text,
    String senderId, {
    MsgType type = MsgType.text,
  }) {
    return MessageModel(
      text: text,
      msgType: type,
      senderId: senderId,
      dateTime: Timestamp.now(),
    );
  }
}
