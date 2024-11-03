import 'package:chat_message/core/chat_controller.dart';
import 'package:chat_message/models/message_model.dart';
import 'package:chat_message/widgets/chat_list_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatMessage Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 0;
  final List<MessageModel> _messageList = [
    MessageModel(
        ownerType: OwnerType.receiver,
        content: "ChatGPT是由OPEN AI 研发的聊天机器人程序",
        createdAt: 1772058683000,
        id: 2,
        avatar: "https://o.devio.org/images/o_as/avatar/tx2.jpeg",
        ownerName: "xiaoyang"),
    MessageModel(
        ownerType: OwnerType.sender,
        content: "介绍撒娇很多撒娇的阿松大",
        createdAt: 1771058683000,
        id: 1,
        avatar: "https://o.devio.org/images/o_as/avatar/tx18.jpeg",
        ownerName: "yanko")
  ];

  late ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: ChatListWidget(
                chatController: chatController,
                onBubbleLongPress: (MessageModel message, context) {
                  debugPrint("onBubbleLongPress: ${message.content}");
                },
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _loadMore, child: const Text("LoadMore")),
                ElevatedButton(onPressed: _send, child: const Text("Send"))
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
        initialMessageList: _messageList,
        scrollController: ScrollController(),
        // messageWidgetBuilder: _diyMessageWidget,
        timePellet: 60);
  }

  void _send() {
    chatController.addMessage(MessageModel(
        ownerType: OwnerType.sender,
        content: "Hello ${count++}",
        createdAt: DateTime.now().millisecondsSinceEpoch,
        avatar: "https://o.devio.org/images/o_as/avatar/tx18.jpeg",
        ownerName: "yanko"));
    Future.delayed(const Duration(milliseconds: 2000), () {
      chatController.addMessage(MessageModel(
          ownerType: OwnerType.receiver,
          content: "Nice",
          createdAt: DateTime.now().millisecondsSinceEpoch,
          avatar: "https://o.devio.org/images/o_as/avatar/tx2.jpeg",
          ownerName: "xiaoyang"));
    });
  }

  int _counter = 0;

  void _loadMore() {
    var tl = 1772058683000;
    tl = tl - ++_counter * 1000000;
    final List<MessageModel> messageList = [
      MessageModel(
          ownerType: OwnerType.sender,
          content: "Hello ${_counter++}",
          createdAt: tl,
          avatar: "https://o.devio.org/images/o_as/avatar/tx18.jpeg",
          ownerName: "yanko"),
      MessageModel(
          ownerType: OwnerType.receiver,
          content: "Nice",
          createdAt: tl,
          avatar: "https://o.devio.org/images/o_as/avatar/tx2.jpeg",
          ownerName: "xiaoyang")
    ];

    chatController.loadMoreData(messageList);
  }

  Widget _diyMessageWidget(MessageModel message) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
          color: message.ownerType == OwnerType.receiver ? Colors.redAccent : Colors.amberAccent),
      child: Text("${message.ownerName}: ${message.content}"),
    );
  }
}
