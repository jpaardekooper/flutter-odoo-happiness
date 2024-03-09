import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/config/app_config.dart';
import 'package:flutter_happiness_poc/services/auth/auth.dart';
import 'package:flutter_happiness_poc/services/local_storage.dart';
import 'package:flutter_happiness_poc/services/auth/auth_service.dart';
import 'package:flutter_happiness_poc/screens/conversation_screen.dart';
import 'package:flutter_happiness_poc/screens/survey_screen.dart';
import 'package:flutter_happiness_poc/screens/history_screen.dart';
import 'package:flutter_happiness_poc/screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:flutter_happiness_poc/view_model/conversation_view_model.dart';
import 'package:flutter_happiness_poc/view_model/happiness_view_model.dart';
import 'package:flutter_happiness_poc/widgets/auth_wrapper.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(HappinessApp(
    sharedPreferences: sharedPreferences,
  ));
}

class HappinessApp extends StatelessWidget {
  final SharedPreferences? sharedPreferences;

  HappinessApp({this.sharedPreferences}) : assert(sharedPreferences != null);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider(create: (_) => LocalStorage(sharedPreferences!)),
        Provider(create: (_) => AppConfig()),
        Provider(create: (context) {
          final appConfig = Provider.of<AppConfig>(context, listen: false);
          final localStorage =
              Provider.of<LocalStorage>(context, listen: false);

          return OdooClient(appConfig.odooUrl, localStorage.getOdooSession());
        }),
        ChangeNotifierProvider<AuthService>(
          create: (BuildContext context) => AuthService(
            Provider.of(context, listen: false),
            Provider.of(context, listen: false),
            Provider.of<AppConfig>(context, listen: false).odooDb,
          ),
        ),
        ChangeNotifierProvider<HappinessViewModel>(
          create: (BuildContext context) =>
              HappinessViewModel(Provider.of(context, listen: false)),
        ),
        ChangeNotifierProvider<ConversationViewModel>(
          create: (BuildContext context) =>
              ConversationViewModel(Provider.of(context, listen: false)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Happiness Flow',
        theme: appTheme,
        home: AuthWrapper(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: HomeScreen(),
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => HomeScreen(),
              '/survey': (BuildContext context) => SurveyScreen(),
              '/history': (BuildContext context) => HistoryScreen(),
              '/conversation': (BuildContext context) => ConversationScreen(),
            },
          ),
        ),
      ),
    );
  }
}
