import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)), 
          onPressed: () {
            if (context.canPop()) {
              context.pop();
             } else {
              context.go('/categories'); // fallback route
            }
         }
        ),
        title: const Text('Add Expenses', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(context, 'Date', 'April 30, 2024', suffixIcon: Icons.calendar_today),
                    _buildInputField(context, 'Category', 'Select the category', suffixIcon: Icons.keyboard_arrow_down),
                    _buildInputField(context, 'Amount', '\$26,00'),
                    _buildInputField(context, 'Expense Title', 'Dinner'),
                    _buildInputField(context, 'Enter Message', '', isLongField: true),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
  BuildContext context,
  String label,
  String placeholder, {
  IconData? suffixIcon,
  bool isLongField = false,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: isLongField ? 5 : 1,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
              color: isDark ? Colors.white54 : Colors.black54,
            ),
            filled: true,
            fillColor: isDark ? Colors.black : Colors.white,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: const Color(0xFF00D19E))
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
      ],
    ),
  );
}
}

