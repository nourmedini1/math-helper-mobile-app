import 'package:flutter/material.dart';
import 'package:math_helper/core/injection_container.dart';
import 'package:math_helper/core/ui/theme_manager.dart';
import 'package:math_helper/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeManager(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeManager>(context).themeData,
    );
  }
}
