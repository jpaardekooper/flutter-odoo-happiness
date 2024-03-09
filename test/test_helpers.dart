import 'package:flutter_happiness_poc/services/local_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import './test_helpers.mocks.dart';

final mockOdooClient = MockOdooClient();
final mockLocalStorage = MockLocalStorage();

final OdooSession odooSession = OdooSession(
  companyId: 0,
  id: '0',
  dbName: 'DBNAME',
  isSystem: true,
  partnerId: 0,
  serverVersion: 1,
  userId: 1,
  userLang: '1',
  userLogin: '1',
  userName: 'test',
  userTz: 'nl',
);

@GenerateMocks([OdooClient, LocalStorage])
void main() {}
