import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/services/auth/auth.dart';
import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:flutter_happiness_poc/widgets/custom_paint/bottom_wave.dart';
import 'package:flutter_happiness_poc/widgets/custom_paint/small_bottom_wave.dart';
import 'package:flutter_happiness_poc/widgets/drawer/happiness_drawer.dart';
import 'package:flutter_happiness_poc/widgets/textfield/card_title.dart';
import 'package:flutter_happiness_poc/widgets/textfield/happiness_card.dart';
import 'package:flutter_happiness_poc/widgets/textfield/subtitle_text.dart';
import 'package:flutter_happiness_poc/widgets/textfield/title_text.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  @override
  void initState() {
    try {
      Provider.of<HappinessViewModel>(context, listen: false).fetchHappiness();
      loading = true;
    } on OdooException catch (_) {
      loading = false;
    }

    super.initState();
  }

  Column welcomeMessage() {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
        ),
        TitleText(
            'Welkom ${_auth.client.sessionId!.userName}', 20, raisinBlack),
        SizedBox(
          height: 10,
        ),
        SubtitleText(
            // ignore: lines_longer_than_80_chars
            'Fijn dat je weer terug bent! Hieronder is er een overzicht van de laatste behaalde doelen',
            14,
            raisinBlack),
        SubtitleText('Veel plezier!', 14, raisinBlack)
      ],
    );
  }

  Widget lastHappinessMeasure() {
    final _happiness = Provider.of<HappinessViewModel>(context, listen: true);
    return HappinessCard(
      _happiness.happiness != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CardTitle('Happiness'),
                Text('Uw laatste happiness is gemeten op:'),
                SizedBox(
                  height: 10,
                ),
                TitleText(
                    // ignore: lines_longer_than_80_chars
                    "${_happiness.happiness!.create_date.day}-${_happiness.happiness!.create_date.month}-${_happiness.happiness!.create_date.year}",
                    18,
                    raisinBlack)
              ],
            )
          : Container(),
    );
  }

  Widget historyScreen() {
    return HappinessCard(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CardTitle('Stats'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/history');
                  },
                  child: Text('Bekijk je geschiedenis')),
            ),
          ),
        ],
      ),
    );
  }

  Widget conversationScreen() {
    return HappinessCard(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CardTitle('Gesprek aanvragen'),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/conversation');
                  },
                  child: Text('Vraag een gesprek aan')),
            ),
          ),
        ],
      ),
    );
  }

  Widget lastHappiness(int difference) {
    return HappinessCard(
      difference < 0
          ? startHappiness()
          : Column(
              children: [
                CardTitle('Happiness'),
                SubtitleText(
                    // ignore: lines_longer_than_80_chars
                    'Aantal dagen te wachten voor een nieuwe Happiness meting:',
                    14,
                    raisinBlack),
                SizedBox(
                  height: 10,
                ),
                TitleText('$difference', 24, raisinBlack),
              ],
            ),
    );
  }

  Widget startHappiness() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CardTitle('Happiness'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              child: Text('Start de Happiness meting'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/survey');
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _happiness = Provider.of<HappinessViewModel>(context, listen: true);
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home pagina"),
      ),
      drawer: MyDrawer('Home'),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(_size.width, 350),
                painter: SmallBottomWave(
                  Colors.transparent,
                  aquamarine,
                  oceanGreen,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    size: Size(_size.width, _size.height),
                    painter: BottomWave(
                      raisinBlack,
                      oceanGreen,
                      aquamarine,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    welcomeMessage(),
                    SizedBox(
                      height: 30,
                    ),
                    _happiness.happinessList.isEmpty
                        ? startHappiness()
                        : loading
                            ? lastHappiness(_happiness.calculateDifference())
                            : Container(),
                    SizedBox(
                      height: 30,
                    ),
                    lastHappinessMeasure(),
                    SizedBox(
                      height: 20,
                    ),
                    historyScreen(),
                    SizedBox(
                      height: 20,
                    ),
                    conversationScreen(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
