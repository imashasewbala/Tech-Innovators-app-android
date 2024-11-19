import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_year_project2024/src/models/bar_chart_model.dart';

class BarChartPage extends StatelessWidget {
  final List<BarChartModel> data = [
    BarChartModel(
      quality: "ESH",
      financial: 65,
      color: Colors.brown[300]!,
    ),
    BarChartModel(
      quality: "H",
      financial: 50,
      color: Colors.brown[300]!,
    ),
    BarChartModel(
      quality: "M",
      financial: 35,
      color: Colors.brown[300]!,
    ),
    BarChartModel(
      quality: "L",
      financial: 60,
      color: Colors.brown[300]!,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF3E7),
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFDF3E7),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Section
            Text(
              "2024 July 1st week",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Summary of Quality Assessments of Cinnamon",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.brown[400],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Chart Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 70,
                    barTouchData: BarTouchData(enabled: true),
                    barGroups: data.map((e) {
                      return BarChartGroupData(
                        x: data.indexOf(e),
                        barRods: [
                          BarChartRodData(
                            toY: e.financial.toDouble(),
                            rodStackItems: [
                              BarChartRodStackItem(0, e.financial.toDouble(), e.color),
                            ],
                            gradient: LinearGradient(
                              colors: [e.color.withOpacity(0.7), e.color],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            width: 24,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      );
                    }).toList(),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: 10,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt()}',
                              style: TextStyle(
                                color: Colors.brown[300],
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 35,
                          interval: 1,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final quality = data[value.toInt()].quality;
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                quality,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      drawHorizontalLine: true,
                      horizontalInterval: 10,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.brown[200],
                          strokeWidth: 0.5,
                          dashArray: const [4, 4],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Legend Section
            Column(
              children: [
                _buildLegendItem("ESH - Extra Special High Quality", Colors.brown[700]!),
                _buildLegendItem("H - High Quality", Colors.brown[500]!),
                _buildLegendItem("M - Medium Quality", Colors.brown[400]!),
                _buildLegendItem("L - Low Quality", Colors.brown[300]!),
              ],
            ),
            const SizedBox(height: 30),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
    "This chart categorizing cinnamon into different quality levels based on their characteristics. ",
    style: TextStyle(
      fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 14,
    height: 1.5,
    ),
    textAlign: TextAlign.center,
    ),
    ),
          ],
        ),
      ),
    );
  }

  // Helper method to build legend items
  Widget _buildLegendItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
