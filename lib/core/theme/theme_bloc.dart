import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme_mode';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

// State
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.dark});

  bool get isDark => themeMode == ThemeMode.dark;

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeMode initialMode = ThemeMode.dark})
    : super(ThemeState(themeMode: initialMode)) {
    on<ToggleTheme>(_onToggleTheme);
  }

  /// Call before runApp to get the persisted theme instantly.
  static Future<ThemeMode> getSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_themeKey);
    if (stored == 'light') return ThemeMode.light;
    return ThemeMode.dark;
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final newMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      newMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
