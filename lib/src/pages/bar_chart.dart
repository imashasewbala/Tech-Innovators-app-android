import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:final_year_project2024/src/models/bar_chart_model.dart';

class BarChartPage extends StatelessWidget {
  final List<BarChartModel> data = [
    BarChartModel(
      quality: "ESH",
      financial: 65,
      color: Colors.teal,
    ),
    BarChartModel(
      quality: "H",
      financial: 50,
      color: Colors.teal,
    ),
    BarChartModel(
      quality: "M",
      financial: 35,
      color: Colors.teal,
    ),
    BarChartModel(
      quality: "L",
      financial: 60,
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("2024 March \n1st week"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Summary of quality assessments of cinnamon within this week",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: data.map((e) {
                    return BarChartGroupData(
                      x: data.indexOf(e),
                      barRods: [
                        BarChartRodData(
                          toY: e.financial.toDouble(),
                          color: e.color,
                          width: 20,
                          borderRadius: BorderRadius.zero,
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        interval: 10,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(
                              color: Colors.black,
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
                          final year = data[value.toInt()].quality;
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              year,
                              style: const TextStyle(
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
                        color: Colors.grey,
                        strokeWidth: 0.5,
                        dashArray: const [4, 4],
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "ESH - Extra Special High Quality",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "H - High Quality",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "M - Medium Quality",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "L - Low Quality",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              child: const Text("See Market Prices information in this week"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}