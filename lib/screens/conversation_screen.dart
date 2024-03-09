import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/models/conversation.dart';
import 'package:flutter_happiness_poc/view_model/conversation_view_model.dart';

import 'package:flutter_happiness_poc/widgets/drawer/happiness_drawer.dart';
import 'package:flutter_happiness_poc/widgets/textfield/happines_formfield.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  static const String routeName = '/conversation';
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<ConversationScreen> {
  late TextEditingController textController;
  bool showRequest = false;

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();

    Provider.of<ConversationViewModel>(context, listen: false)
        .fetchConversationData();
  }

  Column requestConversation() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Opmerking'),
        SizedBox(
          height: 8,
        ),
        HappinessFormField(textController),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await Provider.of<ConversationViewModel>(context, listen: false)
                    .sendConversartionRequest(textController.text);
              } on OdooException catch (_) {}
            },
            child: Text("Verstuur"),
          ),
        ),
      ],
    );
  }

  Widget showWaitTimeMSg() {
    return Text('Op dit moment kunt u geen gesprek aanvragen');
  }

  Color statusColor(Conversation conv) {
    switch (conv.status) {
      case 'done':
        return Colors.green;
      case 'in_progress':
        return Colors.orange;
      case 'draft':
        return Colors.blue;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _conv = Provider.of<ConversationViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Gesprek aanvragen"),
      ),
      drawer: MyDrawer('Conversation'),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: [
            Center(
              child:
                  _conv.showRequest ? requestConversation() : showWaitTimeMSg(),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Laatste aanvraag is gedaan op:'),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _conv.conversationList.length,
              itemBuilder: (context, index) {
                final Conversation detail = _conv.conversationList[index];
                return ListTile(
                  leading: Icon(Icons.circle, color: statusColor(detail)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(detail.status.toString()),
                      Text(
                          // ignore: lines_longer_than_80_chars
                          "${detail.create_date.day}-${detail.create_date.month}-${detail.create_date.year}")
                    ],
                  ),
                  subtitle: Text(detail.comment),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
