import 'package:flutter/material.dart';
import 'package:chaty/core/utils/helper.dart';
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
    _fetchMoreMessages();
    _listenToScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
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

  void _fetchMoreMessages({int limit = 15}) async {
    final chatCubit = ChatCubit.get(context);
    final messagesSource = chatCubit.listOFMsgs;

    if (messages.length >= messagesSource.length && messages.isNotEmpty) {
      Future(() => displayToastMsg(context, "All messages are loaded"));
      setState(() => _isLoading = false);
      return;
    }

    final start = (messagesSource.length - messages.length - limit)
        .clamp(0, messagesSource.length);
    final end = messagesSource.length;

    messages.addAll(messagesSource.sublist(start, end));
    setState(() => _isLoading = false);
  }

  _fetchChatMessages() async {
    final chatCubit = ChatCubit.get(context);
    chatCubit.listOFMsgs.clear();
    if (chatCubit.openedChat == null) return;
    _setCachedMessages(chatCubit);
    await ChatCubit.get(context).fetchChatMessages();
  }

  void _setCachedMessages(ChatCubit chatCubit) {
    if (chatCubit.openedChat!.messages != null &&
        chatCubit.openedChat!.messages!.isNotEmpty) {
      chatCubit.listOFMsgs.addAll(chatCubit.openedChat!.messages!);
    }
  }

  void _listenToScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        setState(() => _isLoading = true);
        _debounce.call(() => _fetchMoreMessages());
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
