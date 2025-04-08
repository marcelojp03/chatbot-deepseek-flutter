import 'dart:developer';

import 'package:chatbot_deepseek/entities/message.dart';
import 'package:chatbot_deepseek/services/deepseek_service.dart';
import 'package:chatbot_deepseek/services/flask_service.dart';
import 'package:chatbot_deepseek/services/speech_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:markdown/markdown.dart' as md;


final chatProviderNotifier = ChangeNotifierProvider((ref) => ChatProvider());

class ChatProvider extends ChangeNotifier {
  final chatScrollController = ScrollController();
  final FlutterTts _flutterTts = FlutterTts();
  final SpeechService _speechService = SpeechService();
  
  List<Message> messageList = [];
  final DeepSeekService _deepSeekService = DeepSeekService();
  final FlaskService _flaskService = FlaskService();
  bool stt = false;

  ChatProvider() {
    _initTTS();
  }

  Future<void> _initTTS() async {
    await _flutterTts.setLanguage("es-ES");
    await _flutterTts.setPitch(1.0);
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    botReplyFlask(text);
    notifyListeners();
    moveScrollToBottom();
  }


Future<void> botReplyFlask(String message) async {

    // Agrega un mensaje vacío con isLoading=true
    final loadingMessage = Message(text: '', fromWho: FromWho.bot, isLoading: true);
    messageList.add(loadingMessage);
    notifyListeners();

    // Obtiene la respuesta del bot
    //var response = await _deepSeekService.getChatResponse(message);
    var response = await _flaskService.getChatResponse(message);
    
    if(response.isEmpty){
      log("la respuesta es nula");
      while(response.isEmpty){
        response = await _deepSeekService.getChatResponse(message);
      }
    }
    log(response.toString());

    // Remueve el mensaje en carga y añade la respuesta real
    messageList.remove(loadingMessage);
    final botMessage = Message(text: response, fromWho: FromWho.bot);
    messageList.add(botMessage);
    notifyListeners();
    moveScrollToBottom();

    if(stt){
      // Convertir Markdown a texto plano antes de hablar
      String plainText = markdownToPlainText(response);
      _flutterTts.speak(plainText);
      stt = false;
    }
  }

  Future<void> botReply(String message) async {

    // Agrega un mensaje vacío con isLoading=true
    final loadingMessage = Message(text: '', fromWho: FromWho.bot, isLoading: true);
    messageList.add(loadingMessage);
    notifyListeners();

    // Obtiene la respuesta del bot
    var response = await _deepSeekService.getChatResponse(message);
    
    if(response.isEmpty){
      log("la respuesta es nula");
      while(response.isEmpty){
        response = await _deepSeekService.getChatResponse(message);
      }
    }
    log(response.toString());

    // Remueve el mensaje en carga y añade la respuesta real
    messageList.remove(loadingMessage);
    final botMessage = Message(text: response, fromWho: FromWho.bot);
    messageList.add(botMessage);
    notifyListeners();
    moveScrollToBottom();

    if(stt){
      // Convertir Markdown a texto plano antes de hablar
      String plainText = markdownToPlainText(response);
      _flutterTts.speak(plainText);
      stt = false;
    }
  }



String markdownToPlainText(String markdownText) {
  return md.Document().parseInline(markdownText).map((node) {
    if (node is md.Text) {
      return node.text;
    }
    return '';
  }).join();
}


  Future<void> startListening(Function(String) onResult) async {
    _flutterTts.stop(); // detiene la voz si se va a usar el microfono de nuevo
    _flutterTts.cancelHandler;
    stt = true;
    bool available = await _speechService.initSpeech();
    if (available) {
      _speechService.startListening(onResult);
    }
  }

  void stopListening() {
    _speechService.stopListening();
  }


  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}

