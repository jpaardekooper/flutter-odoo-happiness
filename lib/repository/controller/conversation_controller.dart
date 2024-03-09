import 'package:flutter_happiness_poc/models/conversation.dart';
import 'package:flutter_happiness_poc/repository/odoo_repistory_interface.dart';
import 'package:flutter_happiness_poc/repository/odoo_repository.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class ConversationController {
  final IOdooRepistory _odooRepistory = OdooRepistory();

  Future<List<Conversation>> fetchConversationData(OdooClient client) {
    return _odooRepistory.getConversationDataFromOdoo(client);
  }

  Future<void> sendConversation(OdooClient client, String comment) {
    return _odooRepistory.setConversationData(client, comment);
  }
}
