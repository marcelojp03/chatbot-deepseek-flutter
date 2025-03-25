import 'package:chatbot_deepseek/entities/message.dart';
import 'package:chatbot_deepseek/provider/chat_provider.dart';
import 'package:chatbot_deepseek/widgets/chat/bot_message_bubble.dart';
import 'package:chatbot_deepseek/widgets/chat/my_message_bubble.dart';
import 'package:chatbot_deepseek/widgets/shared/message_field_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});
  static const name = 'chat';
  //final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("DeepSeek Chatbot"), 
        centerTitle: true
        ),
      body: 
      _ChatView()
    );
  }
}


class _ChatView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatProvider = ref.watch(chatProviderNotifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];
                       
                      return (message.fromWho == FromWho.bot)
                          ? BotMessageBubble( message: message )
                          : MyMessageBubble( message: message );
                    }
                    )
                    ),

            /// Caja de texto de mensajes
            MessageFieldBox(
              // onValue: (value) => chatProvider.sendMessage(value),
              onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

