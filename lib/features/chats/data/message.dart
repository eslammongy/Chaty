class MessageModel {
  final String text;
  final String senderId;
  final String receiverId;
  final DateTime dateTime;
  final bool isSenderMsg;

  MessageModel({
    required this.text,
    required this.senderId,
    this.isSenderMsg = false,
    required this.receiverId,
    required this.dateTime,
  });
}
