import 'dart:developer';

import 'package:chatbot_deepseek/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
      hintText: 'Enviar un mensaje a DeepSeek',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textValue = textController.value.text;
          textController.clear();
          onValue(textValue);
        },
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center, // centrar texto y boton
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        onValue(value);
      },
    );
  }
}
*/


class MessageFieldBox extends ConsumerStatefulWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});

  @override
  ConsumerState<MessageFieldBox> createState() => _MessageFieldBoxState();
}

class _MessageFieldBoxState extends ConsumerState<MessageFieldBox> {
  final TextEditingController textController = TextEditingController();
  final focusNode = FocusNode();
  bool isListening = false;
  final ScrollController scrollController = ScrollController(); 

  void _startListening() {
    setState(() => isListening = true);
    ref.read(chatProviderNotifier).startListening((text) {
      textController.text = text;
      log("Texto reconocido: "+text);
      _scrollToBottom();
      setState(() {}); // Actualiza el campo de texto mientras habla
    });
  }

  void _stopListening() {
    setState(() => isListening = false);
    ref.read(chatProviderNotifier).stopListening();
    _sendMessage();
  }

  void _sendMessage() {
    final textValue = textController.text;
    textController.clear();
    widget.onValue(textValue);
    log("Mensaje enviado: "+textValue);
  }

  void _scrollToBottom() { // NUEVO
    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {


    final outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    final inputDecoration = InputDecoration(
      hintText: 'Escribe o habla un mensaje...',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(isListening ? Icons.mic_off : Icons.mic),
            onPressed: isListening ? _stopListening : _startListening,
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );

    /*return TextFormField(
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.center,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: (value) {
        textController.clear();
        focusNode.requestFocus();
        widget.onValue(value);
      },
    );*/
    return SingleChildScrollView( // NUEVO
      controller: scrollController, // NUEVO
      reverse: true, // NUEVO: Para que el texto crezca desde abajo
      child: TextFormField(
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        controller: textController,
        decoration: inputDecoration,
        maxLines: null, // NUEVO: Permite crecimiento dinámico
        keyboardType: TextInputType.multiline, // NUEVO: Soporta múltiples líneas
        onFieldSubmitted: (value) {
          textController.clear();
          focusNode.requestFocus();
          widget.onValue(value);
        },
      ),
    );
  }
}
