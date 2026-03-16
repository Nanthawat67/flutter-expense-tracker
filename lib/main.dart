import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/item_provider.dart';
import 'screens/dashboard_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fridge Inventory",
      theme: AppTheme.lightTheme,
      home: const DashboardScreen(),
    );
  }
}