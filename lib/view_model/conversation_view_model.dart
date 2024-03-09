import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/models/conversation.dart';
import 'package:flutter_happiness_poc/repository/controller/conversation_controller.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class ConversationViewModel with ChangeNotifier {
  final ConversationController _conversationController =
      ConversationController();
  final OdooClient client;

  ConversationViewModel(this.client);

  List<Conversation> conversationList = [];

  bool showRequest = true;

  fetchConversationData() async {
    try {
      conversationList =
          await _conversationController.fetchConversationData(client);
      checkConversation();
    } on OdooException catch (_) {
      log(_.toString());
    }
  }

  sendConversartionRequest(String comment) async {
    try {
      await _conversationController.sendConversation(client, comment);
      showRequest = false;
    } on OdooException catch (_) {
      log(_.toString());
    }
    notifyListeners();
  }

  checkConversation() {
    var contain = conversationList.where((element) =>
        element.status == "draft" || element.status == 'in_progress');
    if (contain.isEmpty) {
      showRequest = true;
    } else {
      showRequest = false;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    conversationList.clear();
    super.dispose();
  }
}
