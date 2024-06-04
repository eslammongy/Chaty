import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';

List<MessageModel> fakeMessages = [
  MessageModel(
    text: "Lorem ipsum dolor sit amet.",
    senderId: "sender1",
    dateTime: Timestamp.now(),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender2",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Consectetur adipiscing elit.",
    senderId: "sender3",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: "Sed do eiusmod tempor incididunt ut labore.",
    senderId: "sender4",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender5",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Ut enim ad minim veniam.",
    senderId: "sender6",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: "Quis nostrud exercitation ullamco laboris.",
    senderId: "sender7",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender8",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Nisi ut aliquip ex ea commodo consequat.",
    senderId: "sender9",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender10",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Duis aute irure dolor in reprehenderit in voluptate.",
    senderId: "sender11",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender12",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Velit esse cillum dolore eu fugiat nulla pariatur.",
    senderId: "sender13",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender14",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Excepteur sint occaecat cupidatat non proident.",
    senderId: "sender15",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender16",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Sunt in culpa qui officia deserunt mollit anim id est laborum.",
    senderId: "sender17",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender18",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    senderId: "sender19",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender20",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    senderId: "sender21",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.",
    senderId: "sender23",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender24",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "sender25",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender26",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "sender27",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender28",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "sender29",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "sender30",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
];
