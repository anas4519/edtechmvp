import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_bloc.dart';
import 'features/home/bloc/home_cubit.dart';
import 'features/navigation/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TufApp());
}

class TufApp extends StatelessWidget {
  const TufApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
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
