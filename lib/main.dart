import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'features/home/bloc/home_cubit.dart';
import 'features/navigation/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedMode = await ThemeBloc.getSavedThemeMode();
  runApp(TufApp(initialThemeMode: savedMode));
}

class TufApp extends StatelessWidget {
  final ThemeMode initialThemeMode;

  const TufApp({super.key, required this.initialThemeMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc(initialMode: initialThemeMode)),
        BlocProvider(create: (_) => HomeCubit()..loadHome()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'TUF+',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeState.themeMode,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}
