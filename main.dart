import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart'; // this is auto-generated by FlutterFire CLI
import 'pages/home_page.dart';
import 'pages/add_transaction_page.dart';
import 'pages/reports_page.dart';
import 'pages/budget_page.dart';
import 'pages/settings_page.dart';
import 'pages/financial_plan_form.dart';
import 'pages/login_page.dart';
import 'models/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
      home: const AuthWrapper(), // Automatically navigates to Login or Home
      routes: {
        '/add': (context) => const AddTransactionPage(),
        '/budget': (context) => const BudgetPage(),
        '/reports': (context) => const ReportsPage(),
        '/settings': (context) => const SettingsPage(),
        '/plan': (context) => const FinancialPlanFormPage(),
        '/login': (context) => const LoginRegisterPage(),
      },
    );
  }
}
