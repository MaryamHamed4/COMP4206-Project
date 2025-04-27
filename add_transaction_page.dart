import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String _type = 'expense';
  String? _category;
  DateTime _selectedDate = DateTime.now();
  File? _imageFile;

  final List<String> _categories = ['Food', 'Transport', 'Salary', 'Rent', 'Other'];

  // ====================== Actions ======================

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_category == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category.')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction added succefully ! ')),
      );
      Navigator.pushNamed(context, '/');
    }
  }

  // ====================== Widgets ======================

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'Title'),
      validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      decoration: const InputDecoration(labelText: 'Amount'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter an amount';
        final amount = double.tryParse(value);
        if (amount == null || amount <= 0) return 'Enter a valid amount';
        return null;
      },
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        Radio<String>(
          value: 'income',
          groupValue: _type,
          onChanged: (value) => setState(() => _type = value!),
        ),
        const Text('Income'),
        Radio<String>(
          value: 'expense',
          groupValue: _type,
          onChanged: (value) => setState(() => _type = value!),
        ),
        const Text('Expense'),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _category,
      hint: const Text('Select Category'),
      items: _categories.map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
      onChanged: (value) => setState(() => _category = value),
      validator: (value) => value == null ? 'Please choose a category' : null,
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: _pickDate,
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageFile != null
            ? Image.file(_imageFile!, height: 100)
            : const Text('No image selected.'),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Upload Receipt'),
        ),
      ],
    );
  }

  // ====================== Build ======================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction'),
        backgroundColor: Colors.green.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleField(),
                _buildAmountField(),
                const SizedBox(height: 16),
                const Text('Type:'),
                _buildTypeSelector(),
                const SizedBox(height: 16),
                _buildCategoryDropdown(),
                const SizedBox(height: 16),
                _buildDatePicker(),
                const SizedBox(height: 16),
                _buildImagePicker(),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit Transaction'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
