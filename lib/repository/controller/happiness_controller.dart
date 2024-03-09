import 'package:flutter_happiness_poc/models/happiness.dart';
import 'package:flutter_happiness_poc/repository/odoo_repistory_interface.dart';
import 'package:flutter_happiness_poc/repository/odoo_repository.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class HappinessController {
  final IOdooRepistory _odooRepistory = OdooRepistory();

  Future<List<Happiness>> fetchHappinessData(OdooClient client) {
    return _odooRepistory.getHappinessDataFromOdoo(client);
  }

  Future<void> sendSurvey(
    OdooClient client,
    String note,
    String happiness,
    bool allow_read,
  ) {
    return _odooRepistory.setSurveyData(client, note, happiness, allow_read);
  }
}
