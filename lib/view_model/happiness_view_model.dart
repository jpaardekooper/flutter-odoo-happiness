import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_happiness_poc/models/happiness.dart';
import 'package:flutter_happiness_poc/repository/controller/happiness_controller.dart';

import 'package:odoo_rpc/odoo_rpc.dart';

class HappinessViewModel with ChangeNotifier {
  final HappinessController _happinessController = HappinessController();
  final OdooClient client;
  Happiness? happiness;

  List<Happiness> happinessList = [];
  List<Happiness> historyHappiness = [];
  List<FlSpot> historyData = [];
  List<int> historyYears = [];

  HappinessViewModel(this.client);

  fetchHappiness() async {
    try {
      happinessList = await _happinessController.fetchHappinessData(client);
    } on OdooException catch (_) {
      log(_.toString());
    }
    notifyListeners();
  }

  fetchHappinessAndSort() async {
    try {
      happinessList = await _happinessController.fetchHappinessData(client);
      happinessList.sort((a, b) => a.create_date.compareTo(b.create_date));
      getHistoryDataPoints(DateTime.now().year);
    } on OdooException catch (_) {
      log(_.toString());
    }
  }

  Future sendHappinessSurvey(
      String note, String happiness, bool allow_read) async {
    try {
      await _happinessController.sendSurvey(
          client, note, happiness, allow_read);
    } on OdooException catch (e) {
      throw e;
    }
  }

  int calculateDifference() {
    happiness = happinessList.first;

    Duration difference = DateTime.now().difference(
      DateTime.parse(
        happiness!.create_date.toString(),
      ),
    );
    int durationInDays = 7 - difference.inDays;

    return durationInDays;
  }

  getHistoryDataPoints(int year) {
    historyHappiness.clear();
    historyYears.clear();
    historyData.clear();

    for (int i = 0; i < happinessList.length; i++) {
      if (!historyYears.contains(happinessList[i].create_date.year)) {
        historyYears.add(happinessList[i].create_date.year);
      }

      if (year == happinessList[i].create_date.year) {
        historyHappiness.add(happinessList[i]);
      }
    }

    for (int y = 0; y < historyHappiness.length; y++) {
      historyData.add(
        FlSpot(
          y.toDouble(),
          historyHappiness[y].happiness.toDouble(),
        ),
      );
    }

    notifyListeners();
  }

  void setSelectedHappiness(Happiness selectedHappiness) {
    happiness = selectedHappiness;
    notifyListeners();
  }

  @override
  void dispose() {
    happinessList.clear();
    historyHappiness.clear();
    historyData.clear();
    historyYears.clear();
    super.dispose();
  }
}
