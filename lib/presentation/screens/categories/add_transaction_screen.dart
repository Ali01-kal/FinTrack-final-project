import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_bloc.dart';
import 'package:fintrack/presentation/blocs/transaction/bloc/transaction_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:fintrack/domain/entities/transaction_entity.dart';


class AddTransactionScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  final TransactionType type; // Income or Expense

  const AddTransactionScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
    required this.type,
  });

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isIncome = widget.type == TransactionType.income;
    final primaryColor = Colors.amber;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
             } else {
              context.go('/categories'); // fallback route
            }
         }
        ),
        title: Text(
          isIncome ? 'Add Income' : 'Add Expenses',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Date'),
                      _buildDateField(),
                      const SizedBox(height: 20),
                      
                      _buildLabel('Category'),
                      _buildReadOnlyField(widget.categoryName, Icons.keyboard_arrow_down),
                      const SizedBox(height: 20),
                      
                      _buildLabel('Amount'),
                      _buildInputField(_amountController, '\$0.00', isNumber: true),
                      const SizedBox(height: 20),
                      
                      _buildLabel(isIncome ? 'Income Title' : 'Expense Title'),
                      _buildInputField(_titleController, isIncome ? 'Salary' : 'Fuel'),
                      const SizedBox(height: 20),
                      
                      _buildLabel('Enter Message'),
                      _buildInputField(_noteController, 'Note...', maxLines: 4),
                      const SizedBox(height: 40),
                      
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            ),
                            onPressed: _saveTransaction,
                            child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Text(text, style: const TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint, {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFE8F5EE),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      validator: (val) => val!.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) setState(() => _selectedDate = date);
      },
      child: _buildReadOnlyField(DateFormat('MMMM dd, yyyy').format(_selectedDate), Icons.calendar_today),
    );
  }

  Widget _buildReadOnlyField(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(color: const Color(0xFFE8F5EE), borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Color(0xFF1B3D3D))),
          Icon(icon, color: const Color(0xFF00D19E), size: 20),
        ],
      ),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      final normalizedAmount = _amountController.text.replaceAll(',', '.').trim();
      final parsedAmount = double.tryParse(normalizedAmount);
      if (parsedAmount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Amount must be a valid number')),
        );
        return;
      }
      final tx = TransactionEntity(
        id: const Uuid().v4(),
        title: _titleController.text,
        amount: parsedAmount,
        date: _selectedDate,
        categoryId: widget.categoryId,
        type: widget.type,
        note: _noteController.text,
      );

      context.read<TransactionBloc>().add(AddTransaction(tx));
      context.pop();
    }
  }
}

