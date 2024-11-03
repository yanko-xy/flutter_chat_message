import 'package:chat_message/widgets/default_message_widget.dart';
import 'package:flutter/material.dart';

import '../core/chat_controller.dart';
import '../models/message_model.dart';

class ChatListWidget extends StatefulWidget {
  // chatList的控制器
  final ChatController chatController;
  final EdgeInsetsGeometry? padding;
  final OnBubbleClick? onBubbleTap;
  final OnBubbleClick? onBubbleLongPress;

  const ChatListWidget(
      {super.key,
      required this.chatController,
      this.padding,
      this.onBubbleTap,
      this.onBubbleLongPress});

  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  ChatController get chatController => widget.chatController;

  MessageWidgetBuilder? get messageWidgetBuilder => chatController.messageWidgetBuilder;

  ScrollController get scrollController => chatController.scrollController;

  Widget get _chatStreamBuilder => StreamBuilder<List<MessageModel>>(
        stream: chatController.messageStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot<List<MessageModel>> snapshot) {
          return snapshot.connectionState == ConnectionState.active
              ? ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  padding: widget.padding,
                  controller: scrollController,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var model = snapshot.data![index];
                    // TODO:
                    return DefaultMessageWidget(
                      key: model.key,
                      message: model,
                      messageWidget: messageWidgetBuilder,
                      onBubbleTap: widget.onBubbleTap,
                      onBubbleLongPress: widget.onBubbleLongPress,
                    );
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: _chatStreamBuilder,
    );
  }

  @override
  void initState() {
    super.initState();
    chatController.widgetReady();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  Widget _buildMessageWidget(
      {required GlobalKey<State<StatefulWidget>> key, required MessageModel message}) {
    return Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: message.ownerType == OwnerType.receiver ? Colors.amberAccent : Colors.blue),
        child: Text("${message.ownerName} ${message.content}"));
  }
}
