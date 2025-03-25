import 'package:chatbot_deepseek/config/app_router.dart';
import 'package:chatbot_deepseek/config/theme/theme.dart';
import 'package:chatbot_deepseek/config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MainApp()
      )
    );
}


class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}