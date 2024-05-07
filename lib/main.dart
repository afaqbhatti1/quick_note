import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_note/view%20model/notes_provider.dart';
import 'package:quick_note/view/notes_home.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NotesProvider>(
      create: (_) => NotesProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Quick Note',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  NotesHomePage(),
      ),
    );
  }
}
