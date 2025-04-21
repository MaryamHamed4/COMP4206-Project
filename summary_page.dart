import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int _currentStep = 0;
  bool _complete = false;

  final List<Step> _steps = [
    Step(
      title: const Text('Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Title: Grocery Shopping"),
          Text("Amount: \$50"),
          Text("Type: Expense"),
          Text("Category: Food"),
          Text("Date: 2025-04-20"),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Receipt'),
      content: Column(
        children: const [
          Text("Receipt Image: Attached"),
        ],
      ),
      isActive: true,
    ),
    Step(
      title: const Text('Confirmation'),
      content: Column(
        children: const [
          Text("Your transaction has been saved successfully!"),
        ],
      ),
      isActive: true,
    ),
  ];

  void _onStepContinue() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep += 1);
    } else {
      setState(() => _complete = true);
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: _complete
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text("Transaction Completed!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: const Text('Back to Home'),
            )
          ],
        ),
      )
          : Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps: _steps,
      ),
    );
  }
}
