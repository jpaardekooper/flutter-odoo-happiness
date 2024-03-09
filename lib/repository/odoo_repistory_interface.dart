import 'package:flutter_happiness_poc/models/conversation.dart';
import 'package:flutter_happiness_poc/models/happiness.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

abstract class IOdooRepistory {
  Future<List<Happiness>> getHappinessDataFromOdoo(OdooClient client);

  Future<void> setSurveyData(
      OdooClient client, String note, String happiness, bool allow_read);
  Future<List<Conversation>> getConversationDataFromOdoo(OdooClient client);
  Future<void> setConversationData(OdooClient client, String comment);
}
