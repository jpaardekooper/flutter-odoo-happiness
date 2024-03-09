import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:flutter_happiness_poc/widgets/custom_paint/small_bottom_wave.dart';
import 'package:flutter_happiness_poc/widgets/drawer/happiness_drawer.dart';
import 'package:flutter_happiness_poc/widgets/textfield/subtitle_text.dart';
import 'package:flutter_happiness_poc/widgets/history/line_graph.dart';
import 'package:flutter_happiness_poc/widgets/history/pie_chart.dart';
import 'package:flutter_happiness_poc/widgets/textfield/title_text.dart';
import 'package:provider/provider.dart';
import 'package:week_of_year/week_of_year.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  initState() {
    super.initState();

    Provider.of<HappinessViewModel>(context, listen: false)
        .fetchHappinessAndSort();
  }

  Widget showSelectedHistory() {
    final _history = Provider.of<HappinessViewModel>(context, listen: true);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 16 / 5,
          child: Card(
            color: aquamarine,
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _history.happiness!.note.isEmpty
                    ? Column(
                        children: [
                          SubtitleText(
                              'Geen opmerking geplaatst op:', 14, raisinBlack),
                          SizedBox(
                            height: 10,
                          ),
                          SubtitleText(
                              // ignore: lines_longer_than_80_chars
                              "Week nr: ${_history.happiness!.create_date.weekOfYear}",
                              14,
                              raisinBlack),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubtitleText(
                              // ignore: lines_longer_than_80_chars
                              "Opmerking van Week nr: ${_history.happiness!.create_date.weekOfYear}:",
                              14,
                              raisinBlack),
                          SizedBox(
                            height: 10,
                          ),
                          SubtitleText(_history.happiness!.note.toString(), 14,
                              raisinBlack),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showLineGraphData() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [LineGraph()],
      ),
    );
  }

  Widget showPieChartData() {
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 125,
          ),
          TitleText('Overzicht Happiness PieChart', 18, raisinBlack),
          SizedBox(height: 10),
          SubtitleText(
              // ignore: lines_longer_than_80_chars
              'Hieronder is er een overzicht van alle ingevulde happiness metingen. Klik op een taartpunt om het aantal te zien',
              14,
              raisinBlack),
          SizedBox(height: 60),
          SizedBox(
            height: _size.height / 2,
            width: _size.width,
            child: HappinessPieChart(),
          )
        ],
      ),
    );
  }

  Widget showLineChartHeading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 125,
          ),
          TitleText('Overzicht Happiness LineChart', 18, raisinBlack),
          SizedBox(height: 20),
          SubtitleText(
              // ignore: lines_longer_than_80_chars
              'Hieronder is er een overzicht van alle ingevulde happiness metingen. Scroll naar rechts om meerdere weeknummers te zien. Selecteer in de dropdown button van welk jaar u het overzicht wilt zien',
              14,
              raisinBlack),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Geschiedenis pagina'),
      ),
      drawer: MyDrawer('History'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(_size.width, 350),
                painter:
                    SmallBottomWave(Colors.transparent, aquamarine, oceanGreen),
              ),
              showPieChartData()
            ],
          ),
          Stack(
            children: [
              CustomPaint(
                size: Size(_size.width, 400),
                painter: SmallBottomWave(raisinBlack, aquamarine, oceanGreen),
              ),
              showLineChartHeading()
            ],
          ),
          Container(
            color: raisinBlack,
            child: showSelectedHistory(),
          ),
          showLineGraphData(),
        ],
      ),
    );
  }
}
