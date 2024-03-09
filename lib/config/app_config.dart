import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

class AppConfig {
  String get odooUrl => dotenv.env['ODOO_URL'].toString();
  String get odooDb => dotenv.env['ODOO_DB'].toString();
}
