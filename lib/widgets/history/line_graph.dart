import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:provider/provider.dart';
import 'package:week_of_year/week_of_year.dart';

class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  final List<Color> gradientColors = [
    const Color.fromARGB(255, 145, 230, 200),
    const Color.fromARGB(255, 85, 205, 150),
  ];

  late List<DropdownMenuItem<int>> _dropdownMenuItems;
  late int _selectedItem;

  void initState() {
    super.initState();
    _selectedItem = 2021;
    _dropdownMenuItems = buildDropDownMenuItems();
  }

  List<DropdownMenuItem<int>> buildDropDownMenuItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int item in Provider.of<HappinessViewModel>(context, listen: false)
        .historyYears) {
      items.add(
        DropdownMenuItem(
          child: Text(item.toString()),
          value: item,
        ),
      );
    }

    return items;
  }

  String emoticonValue(val) {
    switch (val.toInt()) {
      case 1:
        return 'Alarm';
      case 2:
        return 'Stressed';
      case 3:
        return 'Neutral';
      case 4:
        return 'Almost Happy';
      case 5:
        return 'Happy';
    }
    return '';
  }

  LineChart lineData() {
    final _history = Provider.of<HappinessViewModel>(context, listen: true);

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        lineTouchData: LineTouchData(
          touchCallback: (LineTouchResponse lineTouch) {
            final desiredTouch = lineTouch.touchInput is! PointerExitEvent &&
                lineTouch.touchInput is! PointerUpEvent;
            if (desiredTouch && lineTouch.lineBarSpots != null) {
              final value = lineTouch.lineBarSpots![0].x;

              _history.setSelectedHappiness(
                  _history.historyHappiness[value.toInt()]);
            }
          },
          enabled: true,
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((index) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: Colors.pink,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    color: Colors.pink,
                    radius: 9,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.pink,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  emoticonValue(lineBarSpot.y),
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 15,
            getTextStyles: (value) => const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            getTitles: (value) {
              return value.toInt() < _history.historyHappiness.length
                  ? _history
                      .historyHappiness[value.toInt()].create_date.weekOfYear
                      .toString()
                  : '';
            },
            margin: 15,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return '0';
                case 1:
                  return '1';
                case 2:
                  return '2';
                case 3:
                  return '3';
                case 4:
                  return '4';
                case 5:
                  return '5';
                default:
                  return '';
              }
            },
            reservedSize: 2,
            margin: 15,
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1),
        ),
        minX: 0,
        maxX: _history.historyHappiness.length.toDouble() - 1,
        minY: 0,
        maxY: 5,
        lineBarsData: [
          LineChartBarData(
            spots: _history.historyData,
            isCurved: false,
            colors: gradientColors,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox selectYearDropdown() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Jaar',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color.fromARGB(255, 145, 230, 200),
                      border: Border.all()),
                  child: DropdownButton<int>(
                    value: _selectedItem,
                    items: _dropdownMenuItems,
                    isDense: true,
                    onChanged: (value) async {
                      _selectedItem = value!;

                      await Provider.of<HappinessViewModel>(context,
                              listen: false)
                          .getHistoryDataPoints(_selectedItem);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Week nummer overzicht',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            color: Color.fromARGB(255, 45, 40, 55),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 20,
                top: 60,
              ),
              child: lineData(),
            ),
          ),
        ),
        selectYearDropdown()
      ],
    );
  }
}
