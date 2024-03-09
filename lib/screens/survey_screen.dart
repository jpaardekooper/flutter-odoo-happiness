import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:flutter_happiness_poc/widgets/error/snackbar_error_message.dart';
import 'package:flutter_happiness_poc/widgets/textfield/happines_formfield.dart';
import 'package:flutter_happiness_poc/widgets/survey/emoticon_button.dart';
import 'package:flutter_happiness_poc/widgets/survey/toggle.dart';
import 'package:flutter_happiness_poc/widgets/textfield/title_text.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';

class SurveyScreen extends StatefulWidget {
  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController happinessController;
  late TextEditingController noteController;
  bool allow_read = false;

  @override
  void initState() {
    super.initState();
    happinessController = TextEditingController();
    noteController = TextEditingController();
    noteController.text = "";
  }

  _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      try {
        await Provider.of<HappinessViewModel>(
          context,
          listen: false,
        ).sendHappinessSurvey(
          noteController.text,
          happinessController.text,
          allow_read,
        );

        await SnackbarErrorMsg(context, 'Success!', oceanGreen);

        await Navigator.of(context).pushReplacementNamed('/home');
      } on OdooException catch (_) {
        SnackbarErrorMsg(context, 'Er is iets misgegaan', Colors.red);
      }
    }
  }

  void setAllowRead() {
    allow_read = !allow_read;
  }

  Column showHappinessQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText('1. Happiness', 20, raisinBlack),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: EmoticonButton(controller: happinessController),
        ),
      ],
    );
  }

  Column showCommentQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText('2. Opmerking', 20, raisinBlack),
        SizedBox(
          height: 20,
        ),
        HappinessFormField(noteController),
      ],
    );
  }

  Row showToggleBoolQuestion() {
    return Row(
      children: [
        Flexible(
          child: Text(
            'Hierbij geef ik toestemming ',
          ),
        ),
        ToggleAllowRead(setAllowRead),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Weekly Happiness'),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/home'),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                showHappinessQuestion(),
                SizedBox(
                  height: 30,
                ),
                showCommentQuestion(),
                SizedBox(
                  height: 60,
                ),
                showToggleBoolQuestion()
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            child: Text("Verstuur"),
            onPressed: () {
              _submit();
            },
          ),
        ),
      ),
    );
  }
}
