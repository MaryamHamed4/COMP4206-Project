import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:templatemidterm/widgets/nav_bar.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not logged in')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.green.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search by category...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .where('userId', isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  Map<String, double> categoryTotals = {};
                  double incomeTotal = 0;
                  double expenseTotal = 0;

                  for (var doc in docs) {
                    final data = doc.data()! as Map<String, dynamic>;
                    final amount = (data['amount'] ?? 0).toDouble();
                    final type = data['type'] ?? 'expense';
                    final category = (data['category'] ?? 'Other').toLowerCase();

                    if (_searchText.isNotEmpty &&
                        !category.contains(_searchText)) continue;

                    if (type == 'income') {
                      incomeTotal += amount;
                    } else {
                      expenseTotal += amount;
                      categoryTotals[category] =
                          (categoryTotals[category] ?? 0) + amount;
                    }
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Spending by Category',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 200, child: PieChartWidget(data: categoryTotals)),
                        const SizedBox(height: 24),
                        const Text(
                          'Income vs Expenses',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 200, child: BarChartWidget(income: incomeTotal, expenses: expenseTotal)),
                        const SizedBox(height: 24),
                        const Text(
                          'Categories Overview',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: categoryTotals.entries.map((entry) {
                            return Card(
                              elevation: 2,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.category, color: Colors.teal, size: 30),
                                      const SizedBox(height: 8),
                                      Text(
                                        entry.key.toUpperCase(),
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text("\$${entry.value.toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(currentIndex: 3),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final Map<String, double> data;
  const PieChartWidget({super.key, required this.data});

  List<PieChartSectionData> _buildPieSections() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.brown
    ];
    final sections = <PieChartSectionData>[];
    int i = 0;

    data.forEach((category, value) {
      sections.add(
        PieChartSectionData(
          value: value,
          color: colors[i % colors.length],
          title: category,
          radius: 50,
          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
      i++;
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: _buildPieSections(),
        sectionsSpace: 4,
        centerSpaceRadius: 30,
      ),
    );
  }
}

class BarChartWidget extends StatelessWidget {
  final double income;
  final double expenses;

  const BarChartWidget({super.key, required this.income, required this.expenses});

  Widget _buildBottomTitles(double value, TitleMeta meta) {
    switch (value.toInt()) {
      case 1:
        return const Text('Income');
      case 2:
        return const Text('Expenses');
      default:
        return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (income > expenses ? income : expenses) * 1.2,
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: income, color: Colors.green),
          ], showingTooltipIndicators: [0]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: expenses, color: Colors.red),
          ], showingTooltipIndicators: [0]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, getTitlesWidget: _buildBottomTitles),
          ),
        ),
      ),
    );
  }
}
