import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:fintrack/core/constants/app_constants.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
          ThemeState(
            themeMode: _loadSavedThemeMode(),
          ),
        ) {
    on<ThemeChanged>((event, emit) async {
      final newMode = event.isDark ? ThemeMode.dark : ThemeMode.light;
      await _saveThemeMode(newMode);
      emit(ThemeState(themeMode: newMode));
    });
  }

  static ThemeMode _loadSavedThemeMode() {
    final box = Hive.box(AppConstants.kUserBox);
    final savedMode = box.get(AppConstants.kThemeModeKey, defaultValue: 'light') as String;
    return savedMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  static Future<void> _saveThemeMode(ThemeMode mode) async {
    final box = Hive.box(AppConstants.kUserBox);
    await box.put(AppConstants.kThemeModeKey, mode == ThemeMode.dark ? 'dark' : 'light');
  }
}
