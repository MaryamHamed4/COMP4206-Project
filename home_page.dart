import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:templatemidterm/widgets/nav_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _showTransactionDetails(String title, String amount) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Details", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Title: $title", style: GoogleFonts.poppins()),
            Text("Amount: $amount", style: GoogleFonts.poppins()),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            )
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('transactions').doc(docId).delete();
              Navigator.of(ctx).pop();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaction deleted')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade200,
          title: Text(widget.title, style: GoogleFonts.poppins()),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Weekly"),
              Tab(text: "Monthly"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text("Welcome!"),
                accountEmail: Text(user.email ?? 'No email'),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Add Transaction'),
                onTap: () => Navigator.pushNamed(context, '/add'),
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Budget'),
                onTap: () => Navigator.pushNamed(context, '/budget'),
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart),
                title: const Text('Reports'),
                onTap: () => Navigator.pushNamed(context, '/reports'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => Navigator.pushNamed(context, '/settings'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: _logout,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMainContent(user.uid),
            _buildMainContent(user.uid),
          ],
        ),
        bottomNavigationBar: const NavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildMainContent(String userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('transactions')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        double income = 0;
        double expenses = 0;

        for (var doc in docs) {
          final data = doc.data()! as Map<String, dynamic>;
          double amount = (data['amount'] ?? 0).toDouble();
          if (data['type'] == 'income') {
            income += amount;
          } else {
            expenses += amount;
          }
        }

        double balance = income - expenses;

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Image.asset("assets/images/logoMod.jpg", height: 120),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Spendasaurus",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text("Balance Overview", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat("Income", "\$${income.toStringAsFixed(2)}", Colors.green),
                        _buildStat("Expenses", "\$${expenses.toStringAsFixed(2)}", Colors.red),
                        _buildStat("Balance", "\$${balance.toStringAsFixed(2)}", Colors.blue),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Recent Transactions", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                ...docs.map((doc) {
                  final data = doc.data()! as Map<String, dynamic>;
                  final title = data['title'] ?? 'No Title';
                  final amount = (data['amount'] ?? 0).toDouble();
                  final type = data['type'] ?? 'expense';
                  final color = type == 'income' ? Colors.green : Colors.red;
                  final amountText = (type == 'income' ? '+ ' : '- ') + '\$${amount.toStringAsFixed(2)}';

                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.attach_money, color: color),
                      title: Text(title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(amountText, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(context, doc.id),
                          ),
                        ],
                      ),
                      onTap: () => _showTransactionDetails(title, amountText),
                    ),
                  );
                }).toList(),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/reports'),
                      icon: const Icon(Icons.bar_chart),
                      label: const Text("View Reports"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, '/plan'),
                    icon: const Icon(Icons.plagiarism_outlined),
                    label: const Text("Generate Financial Plan"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/money-bag.png'),
                    width: 100,
                    height: 100,
                  ),
                )


              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String amount, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Text(amount, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
