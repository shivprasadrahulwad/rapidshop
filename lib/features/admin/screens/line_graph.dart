import 'package:eshop/constants/global_variables.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineGraph extends StatefulWidget {
  const LineGraph({super.key});

  @override
  State<LineGraph> createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  List<FlSpot> get allSpots => const [
        FlSpot(0, 250),
        FlSpot(1, 205),
        FlSpot(2, 309),
        FlSpot(3, 420),
        FlSpot(4, 500),
        FlSpot(5, 305),
        FlSpot(6, 490),
        FlSpot(7, 330),
        FlSpot(8, 270),
        FlSpot(9, 255),
        FlSpot(10, 207),
        FlSpot(11, 401),
      ];

  List<int> showingTooltipOnSpot = [0];

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpot,
        spots: allSpots,
        barWidth: 3,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              const Color(0xff9DCEFF).withOpacity(0.4),
              const Color(0xff92A3FD).withOpacity(0.4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        dotData: FlDotData(show: false),
        gradient: const LinearGradient(
          colors: [Color(0xff90CEFF), Color(0xff92A3FD)],
        ),
      )
    ];

    final tooltipsOnBar = lineBarsData[0];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text(
                  "Your sales report",
                  style: TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 16,
                      color: GlobalVariables.greyTextColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text(
                      '496383',
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF82D2BA),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.arrow_outward,
                              size: 10,
                            ))),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '3.5%',
                      style: TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 10,
                ),
                // const Text(
                //   "Compared to 2.34% last year",
                //   style: TextStyle(
                //       fontFamily: 'Regular',
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //       color: GlobalVariables.greyColor),
                // ),
               
                    Container(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          showingTooltipIndicators: showingTooltipOnSpot.map(
                            (index) {
                              return ShowingTooltipIndicators([
                                LineBarSpot(
                                  tooltipsOnBar,
                                  lineBarsData.indexOf(tooltipsOnBar),
                                  tooltipsOnBar.spots[index],
                                ),
                              ]);
                            },
                          ).toList(),
                          lineTouchData: LineTouchData(
                            enabled: true,
                            handleBuiltInTouches: false,
                            touchCallback:
                                (FlTouchEvent event, LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return;
                              }
                              if (event is FlTapUpEvent) {
                                final spotIndex =
                                    response.lineBarSpots!.first.spotIndex;
                                showingTooltipOnSpot.clear();
                                setState(() {
                                  showingTooltipOnSpot.add(spotIndex);
                                });
                              }
                            },
                            mouseCursorResolver:
                                (FlTouchEvent event, LineTouchResponse? response) {
                              if (response == null ||
                                  response.lineBarSpots == null) {
                                return SystemMouseCursors.basic;
                              }
                              return SystemMouseCursors.click;
                            },
                            getTouchedSpotIndicator:
                                (LineChartBarData barData, List<int> spotIndexes) {
                              return spotIndexes.map((index) {
                                return TouchedSpotIndicatorData(
                                  FlLine(color: Colors.red),
                                  FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) =>
                                        FlDotCirclePainter(
                                      radius: 3,
                                      color: Colors.white,
                                      strokeWidth: 3,
                                      strokeColor: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: GlobalVariables.greyTextColor,
                              tooltipRoundedRadius: 8,
                              tooltipPadding: const EdgeInsets.all(8),
                              tooltipMargin: 8,
                              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                                return touchedSpots.map((barSpot) {
                                  return LineTooltipItem(
                                    barSpot.y.toString(),
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                          lineBarsData: lineBarsData,
                          minY: 0,
                          maxY: 550,
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const style = TextStyle(
                                    color: Color(0xff68737d),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  );
                                  Widget text;
                                  switch (value.toInt()) {
                                    case 0:
                                      text = const Text('Jan', style: style);
                                      break;
                                    case 1:
                                      text = const Text('Feb', style: style);
                                      break;
                                    case 2:
                                      text = const Text('Mar', style: style);
                                      break;
                                    case 3:
                                      text = const Text('Apr', style: style);
                                      break;
                                    case 4:
                                      text = const Text('May', style: style);
                                      break;
                                    case 5:
                                      text = const Text('Jun', style: style);
                                      break;
                                    case 6:
                                      text = const Text('Jul', style: style);
                                      break;
                                    case 7:
                                      text = const Text('Aug', style: style);
                                      break;
                                    case 8:
                                      text = const Text('Sep', style: style);
                                      break;
                                    case 9:
                                      text = const Text('Oct', style: style);
                                      break;
                                    case 10:
                                      text = const Text('Nov', style: style);
                                      break;
                                    case 11:
                                      text = const Text('Dec', style: style);
                                      break;
                                    default:
                                      text = const Text('', style: style);
                                      break;
                                  }
                                  return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    space: 4,
                                    child: text,
                                  );
                                },
                                reservedSize: 28,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          gridData: FlGridData(
                            show: false,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
