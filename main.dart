import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_transaction_page.dart';
import 'pages/reports_page.dart';
import 'pages/budget_page.dart';
import 'pages/settings_page.dart';
import 'pages/summary_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spendasaurus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Home Page'),
        '/add': (context) => const AddTransactionPage(),
        '/budget': (context) => const BudgetPage(),
        '/reports': (context) => const ReportsPage(),
        '/settings': (context) => const SettingsPage(),
        '/summary': (context) => const SummaryPage(),
      },
    );
  }
}
