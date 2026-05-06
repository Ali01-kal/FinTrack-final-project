import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.push('/settings'),
        ),
        title: const Text('Delete Account', 
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      'Are You Sure You Want To Delete\nYour Account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF1B3D3D),
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                   
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'This action will permanently delete all of your data, and you will not be able to recover it. Please keep the following in mind before proceeding:',
                            style: TextStyle(fontSize: 13, color: Colors.black54),
                          ),
                          SizedBox(height: 15),
                          _BulletPoint('All your expenses, income and associated transactions will be eliminated.'),
                          _BulletPoint('You will not be able to access your account or any related information.'),
                          _BulletPoint('This action cannot be undone.'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    const Text(
                      'Please Enter Your Password To Confirm\nDeletion Of Your Account.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1B3D3D)),
                    ),
                    const SizedBox(height: 20),
                    
                   
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, 
                              color: Colors.black38, size: 20),
                            onPressed: () => setState(() => _isObscure = !_isObscure),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                  
                    ElevatedButton(
                      onPressed: () {
                
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(double.infinity, 55),
                      ),
                      child: const Text('Yes, Delete Account', 
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => context.push('/settings'),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFE8F5E9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(double.infinity, 55),
                      ),
                      child: const Text('Cancel', 
                        style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      selectedItemColor: const Color(0xFF00D19E),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
    );
  }
}


class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black54))),
        ],
      ),
    );
  }
}
