import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaty/core/utils/debouncer.dart';
import 'package:chaty/features/chats/cubit/chat_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/view/widgets/message_item.dart';

class ChattingMsgsListView extends StatefulWidget {
  const ChattingMsgsListView({
    super.key,
  });

  @override
  State<ChattingMsgsListView> createState() => _ChattingMsgsListViewState();
}

class _ChattingMsgsListViewState extends State<ChattingMsgsListView> {
  final ScrollController _scrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 300));
  late final ChatCubit chatCubit;
  bool _isLoading = false;
  late List<MessageModel> msgSource;
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    chatCubit = ChatCubit.get(context);
    // msgSource = chatCubit.openedChat?.messages ?? [];
    // _listenToChatMessages();
    _listenToScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<ChatCubit, ChatStates>(
        listener: (context, state) {
          if (state is ChatFetchChatMsgsState) {
            msgSource = state.messages;
            _fetchMoreMessages();
          }
        },
        child: Expanded(
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
              return MessageItem(msg: messages[index]);
            },
          ),
        ));
  }

  void _fetchMoreMessages({int limit = 20}) async {
    if (messages.length >= msgSource.length && messages.isNotEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    if (msgSource.length <= limit) {
      _reverseMessages(msgSource);
    } else {
      final int start = (messages.isEmpty)
          ? msgSource.length
          : msgSource.length - messages.length;
      final int end = (start - limit < limit) ? 0 : start - limit;

      _reverseMessages(msgSource.sublist(end, start));
    }

    setState(() => _isLoading = false);
  }

  /// Reverse the list of messages so, the last sent message will be on bottom
  _reverseMessages(List<MessageModel> source) {
    for (var i = source.length - 1; i >= 0; i--) {
      messages.add(msgSource[i]);
    }
  }

  /* _listenToChatMessages() async {
    await ChatCubit.get(context)
        .fetchChatMessages(chatId: chatCubit.openedChat?.id ?? "");
  }
 */
  /// Listen to scroll controller, when user scroll to bottom, fetch more messages
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
