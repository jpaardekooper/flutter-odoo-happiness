// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter_happiness_poc/services/auth/auth_service.dart';
import 'package:flutter_happiness_poc/services/auth/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../../test_helpers.dart';

void main() {
  setUp(() {
    when(mockOdooClient.sessionId).thenReturn(odooSession);
  });

  tearDown(() => reset(mockOdooClient));

  test('Initializes with initial state', () async {
    final authProvider =
        AuthService(mockLocalStorage, mockOdooClient, 'database');

    expect(authProvider.value, equals(AuthState.initial()));
  });

  group('checkSession', () {
    setUp(() {
      when(mockOdooClient.checkSession()).thenAnswer((_) => Future.value(true));
    });

    test('calls checkSession function on client', () async {
      final authProvider =
          AuthService(mockLocalStorage, mockOdooClient, 'database');

      await authProvider.checkSession();

      verify(mockOdooClient.checkSession());
    });

    test('AuthState should be authenticated when checksession succeeds',
        () async {
      final authProvider =
          AuthService(mockLocalStorage, mockOdooClient, 'database');

      await authProvider.checkSession();

      expect(authProvider.value, equals(AuthState.authenticated(odooSession)));
    });

    test('AuthState should be error when checksession fails', () async {
      when(mockOdooClient.checkSession()).thenAnswer(
          (_) => Future.error(OdooSessionExpiredException('Session expired')));

      final authProvider =
          AuthService(mockLocalStorage, mockOdooClient, 'database');

      await authProvider.checkSession();

      expect(
        authProvider.value,
        equals(AuthState.error(ErrorType.sessionExpired)),
      );
    });
  });

  group('Signin', () {
    setUp(() {
      when(mockOdooClient.authenticate(any, any, any))
          .thenAnswer((_) => Future.value(odooSession));

      when(mockOdooClient.authenticate(any, any, 'wrong')).thenAnswer(
          (_) => Future.error(OdooException('invalid credentials')));
    });

    test(
      'should call authenticate function',
      () async {
        final authProvider =
            AuthService(mockLocalStorage, mockOdooClient, 'database');
        await authProvider.signin('email', 'pass');

        verify(mockOdooClient.authenticate('database', 'email', 'pass'));
      },
    );

    test(
      'AuthState should be authenticated if user logins succesfully with credientials',
      () async {
        final authProvider =
            AuthService(mockLocalStorage, mockOdooClient, 'database');

        await authProvider.signin('email', 'pass');

        expect(
            authProvider.value, equals(AuthState.authenticated(odooSession)));
      },
    );

    test(
      'AuthState should be errorState if users uses wrong credentials',
      () async {
        final authProvider =
            AuthService(mockLocalStorage, mockOdooClient, 'database');

        await authProvider.signin('email', 'wrong');

        expect(
          authProvider.value,
          equals(AuthState.error(ErrorType.wrongCredentials)),
        );
      },
    );
  });

  test('When state changes to authenticated sessionId should be persisted',
      () async {
    final authProvider =
        AuthService(mockLocalStorage, mockOdooClient, 'database');

    authProvider.value = AuthState.authenticated(odooSession);

    verify(mockLocalStorage.saveOdooSession(odooSession));
  });

  group('Logout', () {
    setUp(() {
      when(mockOdooClient.destroySession())
          .thenAnswer((_) => Future.value(true));

      when(mockLocalStorage.clearOdooSession())
          .thenAnswer((_) => Future.value(true));
    });
    test(
        'When state changes to loggedOut sessionId should be cleared from storage',
        () async {
      final authProvider =
          AuthService(mockLocalStorage, mockOdooClient, 'database');

      authProvider.value = AuthState.loggedOut();

      verify(mockLocalStorage.clearOdooSession());
    });

    test('AuthState should be loggedOut when user logges out ', () async {
      final authProvider =
          AuthService(mockLocalStorage, mockOdooClient, 'database');

      await authProvider.logout();

      expect(
        authProvider.value,
        equals(AuthState.loggedOut()),
      );
    });
  });
}
