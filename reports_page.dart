import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  static const TextStyle sectionTitleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Spending by Category', style: sectionTitleStyle),
            const SizedBox(height: 200, child: PieChartWidget()),
            const SizedBox(height: 24),
            const Text('Income vs Expenses', style: sectionTitleStyle),
            const SizedBox(height: 200, child: BarChartWidget()),
          ],
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  List<PieChartSectionData> _buildPieSections() {
    return [
      PieChartSectionData(value: 40, color: Colors.red, title: 'Food'),
      PieChartSectionData(value: 25, color: Colors.blue, title: 'Transport'),
      PieChartSectionData(value: 20, color: Colors.orange, title: 'Entertainment'),
      PieChartSectionData(value: 15, color: Colors.green, title: 'Utilities'),
    ];
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
  const BarChartWidget({super.key});

  List<BarChartGroupData> _buildBarGroups() {
    return [
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(toY: 2000, color: Colors.green),
      ], showingTooltipIndicators: [0]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(toY: 850, color: Colors.red),
      ], showingTooltipIndicators: [0]),
    ];
  }

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
        maxY: 2500,
        barGroups: _buildBarGroups(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: _buildBottomTitles,
            ),
          ),
        ),
      ),
    );
  }
}
