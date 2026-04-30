import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool isFaqSelected = true; // FAQ немесе Contact Us таңдауын бақылау

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text('Help & FAQS', 
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
          const SizedBox(height: 10),
          const Text('How Can We Help You?', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  // FAQ / Contact Us Toggle
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        _buildToggleButton('FAQ', isFaqSelected, () => setState(() => isFaqSelected = true)),
                        _buildToggleButton('Contact Us', !isFaqSelected, () => setState(() => isFaqSelected = false)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Іздеу жолағы және категориялар (Тек FAQ үшін)
                  if (isFaqSelected) ...[
                    _buildCategoryRow(),
                    const SizedBox(height: 15),
                    _buildSearchField(),
                    const SizedBox(height: 15),
                  ],

                  // Негізгі контент
                  Expanded(
                    child: isFaqSelected ? _buildFaqList() : _buildContactList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildToggleButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00D19E) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(title, 
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black38, 
                fontWeight: FontWeight.bold
              )),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['General', 'Account', 'Services'].map((cat) => 
        Text(cat, style: const TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.w500))
      ).toList(),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF00D19E)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(hintText: 'Search', border: InputBorder.none, hintStyle: TextStyle(fontSize: 14)),
      ),
    );
  }

  Widget _buildFaqList() {
    final faqs = [
      'How to use FinWise?',
      'How much does it cost to use FinWise?',
      'How to contact support?',
      'How can I reset my password if I forget it?',
      'Are there any privacy or data security measures in place?'
    ];
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) => ExpansionTile(
        title: Text(faqs[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        children: const [Padding(padding: EdgeInsets.all(16), child: Text('Answer goes here...'))],
      ),
    );
  }

  Widget _buildContactList() {
    return ListView(
      children: [
        _buildContactItem(Icons.headset_mic_outlined, 'Customer Service'),
        _buildContactItem(Icons.language_outlined, 'Website'),
        _buildContactItem(Icons.facebook_outlined, 'Facebook'),
        _buildContactItem(Icons.chat_bubble_outline, 'Whatsapp'),
        _buildContactItem(Icons.camera_alt_outlined, 'Instagram'),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String title) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Color(0xFF00D19E), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
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