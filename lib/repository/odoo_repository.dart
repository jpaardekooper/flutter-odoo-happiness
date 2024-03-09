import 'package:flutter_happiness_poc/models/conversation.dart';
import 'package:flutter_happiness_poc/models/happiness.dart';
import 'package:flutter_happiness_poc/repository/odoo_repistory_interface.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class OdooRepistory implements IOdooRepistory {
  Future<List<Happiness>> getHappinessDataFromOdoo(OdooClient client) async {
    try {
      var history = await client.callKw({
        'model': 'happiness.response',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [],
        },
      });

      return List<Happiness>.from(
        history.map(
          (model) => Happiness.fromJson(model),
        ),
      );
    } on OdooException catch (_) {
      throw _;
    }
  }

  Future<void> setSurveyData(
    OdooClient client,
    String note,
    String happiness,
    bool allow_read,
  ) async {
    try {
      await client.callKw({
        'model': 'happiness.response',
        'method': 'create',
        'args': [
          {
            'user_id': client.sessionId!.userId,
            'note': note,
            'happiness': double.tryParse(happiness),
            'allowed_read': allow_read,
          },
        ],
        'kwargs': {},
      });
    } on OdooException catch (_) {
      throw _;
    }
  }

  Future<List<Conversation>> getConversationDataFromOdoo(
      OdooClient client) async {
    try {
      var _conv = await client.callKw({
        'model': 'happiness.conversation',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [],
        },
      });

      return List<Conversation>.from(
        _conv.map(
          (model) => Conversation.fromJson(model),
        ),
      );
    } on OdooException catch (_) {
      throw _;
    }
  }

  Future<void> setConversationData(OdooClient client, String comment) async {
    try {
      await client.callKw({
        'model': 'happiness.conversation',
        'method': 'create',
        'args': [
          {
            'user_id': client.sessionId!.userId,
            'comment': comment,
            'status': 'draft',
          },
        ],
        'kwargs': {},
      });
    } on OdooException catch (_) {
      throw _;
    }
  }
}
