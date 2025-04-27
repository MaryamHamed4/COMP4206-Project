import 'package:flutter/material.dart';
import 'package:templatemidterm/widgets/nav_bar.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  final Map<String, double> _budgets = {
    'Food': 300,
    'Transport': 150,
    'Entertainment': 200,
    'Utilities': 100,
  };

  final Map<String, double> _spent = {
    'Food': 120,
    'Transport': 80,
    'Entertainment': 90,
    'Utilities': 60,
  };

  void _editBudget(String category, double newValue) {
    setState(() {
      _budgets[category] = newValue;
    });
  }

  Widget _buildBudgetCard(String category) {
    double budget = _budgets[category]!;
    double spent = _spent[category] ?? 0;
    double percentage = spent / budget;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage > 1.0 ? 1.0 : percentage,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage < 0.75
                    ? Colors.green
                    : (percentage < 1.0 ? Colors.orange : Colors.red),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Spent: \$${spent.toStringAsFixed(2)}"),
                Text("Budget: \$${budget.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 8),
            Slider(
              value: budget,
              min: 50,
              max: 1000,
              divisions: 19,
              label: '\$${budget.toStringAsFixed(0)}',
              onChanged: (value) => _editBudget(category, value),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Overview'),
        backgroundColor: Colors.green.shade200,),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: _budgets.keys.map(_buildBudgetCard).toList(),
      ),
      backgroundColor: Colors.green.shade100,
      bottomNavigationBar: NavBar(currentIndex: 2),
    );
  }
}
