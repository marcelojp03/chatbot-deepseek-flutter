import 'package:chatbot_deepseek/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BotMessageBubble extends StatelessWidget {
  final Message message;

  const BotMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colors.secondary, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: message.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white,),
                )
              : Column(
                children: [
                  MarkdownBody(
                        data: message.text,
                        selectable: true,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(color: Colors.white),
                          strong: const TextStyle(fontWeight: FontWeight.bold),
                          em: const TextStyle(fontStyle: FontStyle.italic),
                          //h1: const TextStyle(fontSize: 24, color: Colors.blue),
                          code: const TextStyle(
                              //fontSize: 14,
                              color: Colors.cyan,
                              //backgroundColor: Colors.black
                          ),
                          blockquote: TextStyle(
                            color: Colors.white70,
                            fontStyle: FontStyle.italic,
                          ),
                          codeblockPadding: EdgeInsets.all(8),
                          codeblockDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton.outlined(
                          tooltip: "Copiar al portapapeles",
                          icon: const Icon(Icons.copy, color: Colors.white),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: message.text));
                          },
                        )
                    ),
                ],
              ) 
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}


/*class _ImageBubble extends StatelessWidget {
  final String imageUrl;

  const _ImageBubble( this.imageUrl );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          width: size.width * 0.7,
          height: 150,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            return Container(
              width: size.width * 0.7,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Text('Mi amor está enviando una imagen'),
            );
          },
        )
      );
  }
}*/
