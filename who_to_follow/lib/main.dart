import 'package:flutter/material.dart';
import 'dependency_injection.dart' as dependency_injection;
import 'screens/user_suggestion/page/suggestion_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injection.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SuggestionPage(),
    );
  }
}
