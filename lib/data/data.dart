import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

String odoo_url = dotenv.env['ODOO_URL'].toString();
String odoo_db = dotenv.env['ODOO_DB'].toString();
