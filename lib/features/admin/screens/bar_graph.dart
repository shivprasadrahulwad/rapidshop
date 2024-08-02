import 'package:eshop/features/admin/screens/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBargraph extends StatelessWidget {
  final List weeklySummary;
  const MyBargraph({
    super.key,
    required this.weeklySummary,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        sun: weeklySummary[0],
        mon: weeklySummary[1],
        tue: weeklySummary[2],
        wed: weeklySummary[3],
        thur: weeklySummary[4],
        fri: weeklySummary[5],
        sat: weeklySummary[6]);

    myBarData.initializeBarData();
    return BarChart(BarChartData(
        maxY: 50,
        minY: 0,
        gridData: FlGridData(show: false,),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
           bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true ,getTitlesWidget: getBottomTitles)),
          
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                x: data.x, barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.grey[800],
                    width: 25,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 40,
                      color: Colors.grey,
                    )
                  )
                ]
              )
            )
            .toList()));
  }
}


Widget getBottomTitles(double value  ,TitleMeta meta){
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );


  Widget text;
  switch(value.toInt()){
    case 0:
      text =  const Text('S' ,style: style,);
      break;
    case 1:
      text =  const Text('M' ,style: style,);
      break;
    case 2:
      text =  const Text('T' ,style: style,);
      break;
    case 3:
      text =  const Text('W' ,style: style,);
      break;
    case 4:
      text =  const Text('T' ,style: style,);
      break;
    case 5:
      text =  const Text('F' ,style: style,);
      break;
    case 6:
      text =  const Text('S' ,style: style,);
      break;
    default:
      text =  const Text('' ,style: style,);
      break;              
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);

}