import 'package:flutter/material.dart';
import 'package:currency_converter/currency_choosing.dart';
import 'package:currency_converter/Home.dart';
import 'package:currency_converter/loading.dart';
import 'package:currency_converter/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const loading_screen(),
        '/home': (context) => const Home(),
        '/location': (context) => const currency_choser(),
      },
    ),
  );
}
