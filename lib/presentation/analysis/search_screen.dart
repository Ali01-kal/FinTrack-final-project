import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String reportType = 'Expense'; // Radio батырмасы үшін

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
        title: const Text('Search', style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Жоғарғы іздеу жолағы (Search bar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search..',
                hintStyle: const TextStyle(color: Colors.black26),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Төменгі ақ блок
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF4FAF6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Categories
                    _buildLabel('Categories'),
                    _buildDropdownField('Select the category'),

                    const SizedBox(height: 20),

                    // 2. Date
                    _buildLabel('Date'),
                    _buildDropdownField('30 /Apr/2023', icon: Icons.calendar_today_outlined),

                    const SizedBox(height: 20),

                    // 3. Report (Radio buttons)
                    _buildLabel('Report'),
                    Row(
                      children: [
                        _buildRadioButton('Income'),
                        const SizedBox(width: 20),
                        _buildRadioButton('Expense'),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // 4. Search Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: const Text('Search', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 5. Result Item (Optional - Дерек табылған кездегі көрініс)
                    _buildResultItem(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(), // Бұны алдыңғы беттен көшіре салсаң болады
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 5),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
    );
  }

  Widget _buildDropdownField(String text, {IconData icon = Icons.keyboard_arrow_down}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF00D19E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.black45)),
          Icon(icon, color: const Color(0xFF00D19E), size: 20),
        ],
      ),
    );
  }

  Widget _buildRadioButton(String title) {
    return GestureDetector(
      onTap: () => setState(() => reportType = title),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF00D19E), width: 2),
            ),
            child: CircleAvatar(
              radius: 6,
              backgroundColor: reportType == title ? const Color(0xFF00D19E) : Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Color(0xFF1B3D3D))),
        ],
      ),
    );
  }

  Widget _buildResultItem() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.restaurant, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dinner', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('18:27 - April 30', style: TextStyle(color: Colors.black26, fontSize: 12)),
              ],
            ),
          ),
          const Text('-\$26,00', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Алдыңғы беттегідей BottomNav
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      selectedItemColor: const Color(0xFF00D19E),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
    );
  }
}