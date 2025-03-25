import 'package:chatbot_deepseek/config/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



//Listado de colores inmutables 
// final colorListProvider = Provider((ref) => colorList);

//Un simple boolean
//final isDarkModeProvider = StateProvider<bool>((ref) => false);

//final selectedColorProvider = StateProvider<int>((ref) => 0);

//Un objeto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier()
);

//Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  // STATE = Estado = new AppTheme();
  ThemeNotifier(): super( AppTheme() );

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
   }

}