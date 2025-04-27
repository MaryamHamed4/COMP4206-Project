import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Dummy NavBar widget
class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Financial Plan'),
      ],
    );
  }
}

class FinancialPlanFormPage extends StatefulWidget {
  const FinancialPlanFormPage({super.key});

  @override
  State<FinancialPlanFormPage> createState() => _FinancialPlanFormPageState();
}

class _FinancialPlanFormPageState extends State<FinancialPlanFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _incomeController = TextEditingController();
  final _goalsController = TextEditingController();

  String? _selectedSavingGoal;
  bool _agreeTerms = false;
  File? _selectedFile;
  DateTime? _selectedDate;

  int _stepNum = 0;
  bool _complete = false;

  final List<String> savingGoals = [
    'Emergency Fund',
    'Retirement',
    'Vacation',
    'Education'
  ];

  Future<void> _pickFile() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    Navigator.pushNamed(context, '/financialPlanSummary', arguments: {
      'email': _emailController.text,
      'income': _incomeController.text,
      'goal': _selectedSavingGoal,
      'planDetails': _goalsController.text,
      'date': _selectedDate.toString(),
    });
  }

  void _onStepContinue() {
    if (_stepNum == 0) {
      if (_formKey.currentState!.validate()) {
        setState(() => _stepNum += 1);
      }
    } else if (_stepNum == 1) {
      if (_formKey.currentState!.validate() && _selectedSavingGoal != null) {
        setState(() => _stepNum += 1);
      } else {
        if (_selectedSavingGoal == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a saving goal')),
          );
        }
      }
    } else if (_stepNum == 2) {
      if (_agreeTerms && _selectedFile != null && _selectedDate != null) {
        setState(() => _complete = true);
        _submitForm();
      } else {
        if (!_agreeTerms) {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Error'),
              content: const Text('You must agree to the terms and conditions.'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
              ],
            ),
          );
        }
        if (_selectedFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please upload a profile image.')),
          );
        }
        if (_selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select a target date.')),
          );
        }
      }
    }
  }

  void _onStepCancel() {
    if (_stepNum > 0) {
      setState(() => _stepNum -= 1);
    }
  }

  List<Step> get _steps => [
    Step(
      title: const Text('Personal Details'),
      isActive: _stepNum >= 0,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ),
    Step(
      title: const Text('Financial Details'),
      isActive: _stepNum >= 1,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _incomeController,
            decoration: const InputDecoration(labelText: 'Monthly Income (OMR)'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your monthly income';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Saving Goal'),
            items: savingGoals.map((goal) {
              return DropdownMenuItem(
                value: goal,
                child: Text(goal),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedSavingGoal = value),
            validator: (value) => value == null ? 'Select a saving goal' : null,
          ),
          TextFormField(
            controller: _goalsController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Describe your financial goals'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe your goals';
              }
              return null;
            },
          ),
        ],
      ),
    ),
    Step(
      title: const Text('Upload and Confirm'),
      isActive: _stepNum >= 2,
      content: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: _pickFile,
                child: const Text('Upload Profile Image'),
              ),
              const SizedBox(width: 10),
              _selectedFile != null
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : const Icon(Icons.error, color: Colors.red),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _pickDate,
            child: const Text('Select Target Date'),
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            title: const Text('I agree to the terms and conditions'),
            value: _agreeTerms,
            onChanged: (value) => setState(() => _agreeTerms = value!),
          ),
        ],
      ),
    ),
  ];

  Widget _buildSuccess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The financial plan is sent in email!')),
      );
    });

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline_rounded, size: 100, color: Colors.green),
          const SizedBox(height: 20),
          const Text("Generating Completed!"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
            child: const Text('Go back to Home'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generating The Financial Plan'),
        backgroundColor: Colors.green.shade200,
      ),
      body: _complete
          ? _buildSuccess()
          : Stepper(
        currentStep: _stepNum,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        steps: _steps,
      ),
      bottomNavigationBar: const NavBar(currentIndex: 4),
    );
  }
}
