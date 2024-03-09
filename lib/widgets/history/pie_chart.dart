import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class HappinessPieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HappinessPieChartState();
}

class HappinessPieChartState extends State {
  int touchedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          setState(() {
            final desiredTouch =
                pieTouchResponse.touchInput is! PointerExitEvent &&
                    pieTouchResponse.touchInput is! PointerUpEvent;
            if (desiredTouch && pieTouchResponse.touchedSection != null) {
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            } else {
              touchedIndex = -1;
            }
          });
        }),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 1,
        centerSpaceRadius: 1,
        sections: showingSections(),
      ),
    );
  }

  String showPercentage(double val) {
    final data = Provider.of<HappinessViewModel>(context, listen: false);
    var value = (val / data.happinessList.length * 100).toInt();
    return '$value %';
  }

  List<PieChartSectionData> showingSections() {
    final data = Provider.of<HappinessViewModel>(context, listen: true);

    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 160.0 : 140.0;
      final widgetSize = isTouched ? 80.0 : 70.0;

      switch (i) {
        case 0:
          double value = data.happinessList
              .where((c) => c.happiness == 1)
              .length
              .toDouble();

          return value == 0.0
              ? PieChartSectionData(
                  title: '-',
                  value: 0.1,
                  color: Colors.red[400],
                )
              : PieChartSectionData(
                  color: Colors.red[400],
                  value: (value / data.happinessList.length.toDouble()) * 100,
                  title: isTouched
                      ? data.happinessList
                          .where((c) => c.happiness == 1)
                          .length
                          .toString()
                      : showPercentage(data.happinessList
                          .where((c) => c.happiness == 1)
                          .length
                          .toDouble()),
                  radius: radius,
                  titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                  badgeWidget: _Badge(
                    'assets/images/alarm.svg',
                    size: widgetSize,
                    borderColor: Colors.red,
                    touched: isTouched,
                    name: 'Alarm',
                  ),
                  badgePositionPercentageOffset: .98,
                );
        case 1:
          double value = data.happinessList
              .where((c) => c.happiness == 2)
              .length
              .toDouble();

          return value == 0.0
              ? PieChartSectionData(
                  title: '-',
                  value: 0.1,
                  color: Color(0xfff8b250),
                )
              : PieChartSectionData(
                  color: Color(0xfff8b250),
                  value: (value / data.happinessList.length.toDouble()) * 100,
                  title: isTouched
                      ? data.happinessList
                          .where((c) => c.happiness == 2)
                          .toList()
                          .length
                          .toString()
                      : showPercentage(data.happinessList
                          .where((c) => c.happiness == 2)
                          .toList()
                          .length
                          .toDouble()),
                  radius: radius,
                  titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                  badgeWidget: _Badge(
                    'assets/images/almost_alarm.svg',
                    size: widgetSize,
                    borderColor: const Color(0xfff8b250),
                    touched: isTouched,
                    name: 'Almost \n alarm',
                  ),
                  badgePositionPercentageOffset: .98,
                );
        case 2:
          double value = data.happinessList
              .where((c) => c.happiness == 3)
              .length
              .toDouble();

          return value == 0.0
              ? PieChartSectionData(
                  title: '-',
                  value: 0.1,
                  color: Colors.blue,
                )
              : PieChartSectionData(
                  color: Colors.blue,
                  value: (value / data.happinessList.length.toDouble()) * 100,
                  title: isTouched
                      ? data.happinessList
                          .where((c) => c.happiness == 3)
                          .toList()
                          .length
                          .toString()
                      : showPercentage(data.happinessList
                          .where((c) => c.happiness == 3)
                          .toList()
                          .length
                          .toDouble()),
                  radius: radius,
                  titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                  badgeWidget: _Badge(
                    'assets/images/neutral.svg',
                    size: widgetSize,
                    borderColor: Colors.blue,
                    touched: isTouched,
                    name: 'Neutral',
                  ),
                  badgePositionPercentageOffset: .98,
                );
        case 3:
          double value = data.happinessList
              .where((c) => c.happiness == 4)
              .length
              .toDouble();

          return value == 0.0
              ? PieChartSectionData(
                  title: '-',
                  value: 0.1,
                  color: const Color(0xff845bef),
                )
              : PieChartSectionData(
                  color: const Color(0xff845bef),
                  value: (value / data.happinessList.length.toDouble()) * 100,
                  title: isTouched
                      ? data.happinessList
                          .where((c) => c.happiness == 4)
                          .toList()
                          .length
                          .toString()
                      : showPercentage(data.happinessList
                          .where((c) => c.happiness == 4)
                          .toList()
                          .length
                          .toDouble()),
                  radius: radius,
                  titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                  badgeWidget: _Badge(
                    'assets/images/almost_happy.svg',
                    size: widgetSize,
                    borderColor: const Color(0xff845bef),
                    touched: isTouched,
                    name: 'Almost \n happy',
                  ),
                  badgePositionPercentageOffset: .98,
                );
        case 4:
          double value = data.happinessList
              .where((c) => c.happiness == 5)
              .length
              .toDouble();
          return value == 0.0
              ? PieChartSectionData(
                  title: '-',
                  value: 0.1,
                  color: const Color(0xff13d38e),
                )
              : PieChartSectionData(
                  color: const Color(0xff13d38e),
                  value: (value / data.happinessList.length.toDouble()) * 100,
                  title: isTouched
                      ? data.happinessList
                          .where((c) => c.happiness == 5)
                          .toList()
                          .length
                          .toString()
                      : showPercentage(data.happinessList
                          .where((c) => c.happiness == 5)
                          .toList()
                          .length
                          .toDouble()),
                  radius: radius,
                  titleStyle: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xffffffff)),
                  badgeWidget: _Badge(
                    'assets/images/happy.svg',
                    size: widgetSize,
                    borderColor: const Color(0xff13d38e),
                    touched: isTouched,
                    name: 'Happy',
                  ),
                  badgePositionPercentageOffset: .98,
                );
        default:
          return PieChartSectionData(
              radius: radius, title: '-', value: 1, color: Colors.transparent);
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;
  final bool touched;
  final String name;

  const _Badge(this.svgAsset,
      {Key? key,
      required this.size,
      required this.borderColor,
      required this.touched,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: touched ? size * 3 : size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 3,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(touched ? 5 : size * .10),
      child: Center(
        child: touched
            ? Text(
                name,
                textAlign: TextAlign.center,
              )
            : SvgPicture.asset(
                svgAsset,
                fit: BoxFit.contain,
                color: borderColor,
              ),
      ),
    );
  }
}
