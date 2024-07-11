import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaty/features/chats/data/models/message.dart';

List<MessageModel> fakeMessages = [
  MessageModel(
    text: "Lorem ipsum dolor sit amet.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.now(),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Consectetur adipiscing elit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: "Sed do eiusmod tempor incididunt ut labore.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Ut enim ad minim veniam.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: "Quis nostrud exercitation ullamco laboris.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Nisi ut aliquip ex ea commodo consequat.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J22",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J220",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Duis aute irure dolor in reprehenderit in voluptate.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J221",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J222",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Velit esse cillum dolore eu fugiat nulla pariatur.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J223",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Excepteur sint occaecat cupidatat non proident.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J226",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: "Sunt in culpa qui officia deserunt mollit anim id est laborum.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J220",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J221",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J223",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J220",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J221",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J223",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J220",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J221",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J223",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J220",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J221",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J223",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J224",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J225",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J227",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J228",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
  MessageModel(
    text:
        "Sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
    senderId: "OSkBoK072YSYBaqqlm9V6YbA9J229",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.text,
  ),
  MessageModel(
    text: null,
    senderId: "0tzK43hDpxTEjy7zzTjBOgw3pM53",
    dateTime: Timestamp.fromDate(DateTime.now()),
    msgType: MsgType.image,
  ),
];
