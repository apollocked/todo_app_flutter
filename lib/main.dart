import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/todo_list_page.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/theme/app_theme.dart';
import 'package:todo_app/utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    // Initialize sample data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoProvider.initialize(AppConstants.sampleTodos);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      themeMode: themeProvider.themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const TodoListPage(),
    );
  }
}
