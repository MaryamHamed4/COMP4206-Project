import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _screens = [
    'Add Transaction',
    'Budget Overview',
    'Reports',
    'Financial Plan Generator',
    'Settings',
  ];

  String _selectedScreen = 'Add Transaction';

  void _navigateToSelectedScreen(String screen) {
    switch (screen) {
      case 'Add Transaction':
        Navigator.pushNamed(context, '/add');
        break;
      case 'Budget Overview':
        Navigator.pushNamed(context, '/budget');
        break;
      case 'Reports':
        Navigator.pushNamed(context, '/reports');
        break;
      case 'Settings':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'Financial Plan Generator':
        Navigator.pushNamed(context, '/plan');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            _navigateToSelectedScreen(value);
          },
          itemBuilder: (context) {
            return _screens
                .map((screen) => PopupMenuItem(
              value: screen,
              child: Text(screen),
            ))
                .toList();
          },
        ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logoMod.jpg",
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Balance Overview",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat("Income", "\$2000", Colors.green),
                      _buildStat("Expenses", "\$850", Colors.red),
                      _buildStat("Balance", "\$1150", Colors.blue),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Recent Transactions",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              _transactionItem("Groceries", "- \$50", Colors.red),
              _transactionItem("Salary", "+ \$2000", Colors.green),
              _transactionItem("Utilities", "- \$100", Colors.red),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/add'),
                    icon: const Icon(Icons.add_circle),
                    label: const Text("Add Transaction"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/reports'),
                    icon: const Icon(Icons.bar_chart),
                    label: const Text("View Reports"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/plan'),
                    icon: Icon(Icons.plagiarism_outlined),
                    label: const Text("Generate Financial Plan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  Widget _buildStat(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        Text(
          amount,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _transactionItem(String title, String amount, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.attach_money, color: color),
        title: Text(title),
        trailing: Text(
          amount,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
