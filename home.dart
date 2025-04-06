import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showMaterialBanner(
              MaterialBanner(
                content: Text("Menu"),
                actions: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    icon: Icon(
                      Icons.close_outlined,
                      color: Colors.teal,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        title: Text(
          'Home page',
          style: GoogleFonts.poppins(),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.0),
          child: Container(
            color: Colors.green.shade200,
            height: 15.0,
            width: double.infinity,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: AssetImage("assets/images/logoMod.jpg"),
                    height: 120,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Balance Overview",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,
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
                SizedBox(height: 20),
                Text(
                  "Recent Transactions",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                _transactionItem("Groceries", "- \$50", Colors.red),
                _transactionItem("Salary", "+ \$2000", Colors.green),
                _transactionItem("Utilities", "- \$100", Colors.red),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle),
                      label: Text("Add Transaction"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.bar_chart),
                      label: Text("View Reports"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to or generate a financial plan here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    child: Text(
                      "Generate Financial Plan",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 6),
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
