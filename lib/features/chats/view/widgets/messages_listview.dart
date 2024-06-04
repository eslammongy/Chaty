import 'dart:math';
import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
import 'package:chaty/core/utils/fake_msg.dart';
import 'package:chaty/core/utils/debouncer.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/view/widgets/message_item.dart';

class MessagesListView extends StatefulWidget {
  const MessagesListView({super.key});

  @override
  State<MessagesListView> createState() => _MessagesListViewState();
}

class _MessagesListViewState extends State<MessagesListView> {
  final ScrollController _scrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 300));
  bool _isLoading = false;

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchChatMessages();
    _fetchMoreMsg();
    _listenToScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: 10.h, left: 0, right: 0),
        physics: const BouncingScrollPhysics(),
        itemCount: messages.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == messages.length) {
            return displayLoadingIndicator(theme);
          }
          final msg = messages[index];
          return MessageItem(msg: msg);
        },
      ),
    );
  }

  void _fetchMoreMsg({int limit = 12}) async {
    final chatCubit = ChatCubit.get(context);

    final startIndex = messages.length;
    final endIndex = min(startIndex + limit, chatCubit.listOFMsgs.length);
    if (messages.length >= chatCubit.listOFMsgs.length) {
      Future(() => displayToastMsg(context, "all messages are loaded"));
    } else {
      messages.addAll(chatCubit.listOFMsgs.sublist(startIndex, endIndex));
    }
    setState(() => _isLoading = false);
  }

  _fetchChatMessages() async {
    final chatCubit = ChatCubit.get(context);
    await Future.delayed(const Duration(milliseconds: 200), () {
      chatCubit.extractChatMsgs(chatId: chatCubit.openedChat.id ?? "");
    });
  }

  void _listenToScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _debounce.call(() => _fetchMoreMsg());
      }
    });
  }

  Center displayLoadingIndicator(ThemeData theme) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            color: theme.colorScheme.primary,
            strokeWidth: 5,
          ),
        ),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
