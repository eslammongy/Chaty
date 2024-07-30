import 'package:flutter/material.dart';
import 'package:chaty/core/utils/debouncer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chaty/features/chats/data/models/message.dart';
import 'package:chaty/features/chats/view/widgets/message_item.dart';

class ChattingMsgsListView extends StatefulWidget {
  const ChattingMsgsListView({
    super.key,
    required this.msgSource,
  });
  final List<MessageModel> msgSource;

  @override
  State<ChattingMsgsListView> createState() => _ChattingMsgsListViewState();
}

class _ChattingMsgsListViewState extends State<ChattingMsgsListView> {
  final ScrollController _scrollController = ScrollController();
  final Debounce _debounce = Debounce(delay: const Duration(milliseconds: 300));
  bool _isLoading = false;
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchMoreMessages();
    _listenToScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    debugPrint("ChattingMsgsListView: ${widget.msgSource.toString()}");

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
          return MessageItem(msg: messages[index]);
        },
      ),
    );
  }

  void _fetchMoreMessages({int limit = 20}) async {
    if (messages.length >= widget.msgSource.length && messages.isNotEmpty) {
      setState(() => _isLoading = false);
      return;
    }

    if (widget.msgSource.length <= limit) {
      messages = widget.msgSource;
    } else {
      final int start = (messages.isEmpty)
          ? widget.msgSource.length
          : widget.msgSource.length - messages.length;
      final int end = (start - limit < limit) ? 0 : start - limit;

      //  _reverseMessages(widget.msgSource.sublist(end, start));
      messages.addAll(widget.msgSource.sublist(end, start));
    }

    setState(() => _isLoading = false);
  }

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
