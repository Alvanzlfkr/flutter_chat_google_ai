import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'widgets/chat_bubble.dart';

const apiKey = 'AIzaSyAcQB9uol3yreaLo87_7FZ5xQ0QtFepC2M';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  TextEditingController messageController = TextEditingController();

  bool isLoading = false;

  List<ChatBubble> chatBubbles = [
    const ChatBubble(
      direction: Direction.left,
      message: 'Hai, I\'m your Assistant AI, what can i help you?',
      photoUrl: 'https://cdn-icons-png.flaticon.com/128/6873/6873405.png',
      type: BubbleType.alone,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Your Assistant AI',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              reverse: true,
              padding: const EdgeInsets.all(10),
              children: chatBubbles.reversed.toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                isLoading
                    ? const CupertinoActivityIndicator()
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          // Send message logic here
                          setState(() {
                            isLoading = true;
                          });
                          final content = [
                            Content.text(messageController.text)
                          ];
                          final GenerateContentResponse responseAI =
                              await model.generateContent(content);

                          chatBubbles = [
                            ...chatBubbles,
                            ChatBubble(
                              direction: Direction.right,
                              message: messageController.text,
                              photoUrl: null,
                              type: BubbleType.alone,
                            )
                          ];
                          chatBubbles = [
                            ...chatBubbles,
                            ChatBubble(
                              direction: Direction.left,
                              message: responseAI.text ??
                                  'Sorry, i don\'t understand what you\'re saying',
                              photoUrl:
                                  'https://cdn-icons-png.flaticon.com/128/6873/6873405.png',
                              type: BubbleType.alone,
                            )
                          ];
                          messageController.clear();
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
