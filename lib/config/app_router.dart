import 'package:chatbot_deepseek/screens/chat_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: "/chat",
  routes: [
    GoRoute(      
      path: '/chat',
      name: ChatScreen.name,
      builder: (context, state) => ChatScreen(),
    ),
  ],
);