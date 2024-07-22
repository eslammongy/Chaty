import 'dart:convert';

class ChatModel {
  String? id;
  List<dynamic>? participants;
  ChatModel({
    this.id,
    this.participants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'participants': participants,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      participants: map['participants'] != null
          ? List<dynamic>.from((map['participants'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());
}
