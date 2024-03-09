import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/services/auth/auth.dart';
import 'package:flutter_happiness_poc/widgets/auth_wrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import '../test_helpers.dart';

Future<AuthService> renderWithAuthService(
  WidgetTester tester, {
  Widget? child,
  AuthService? authService,
}) async {
  authService ??= AuthService(mockLocalStorage, mockOdooClient, 'database');

  await tester.pumpWidget(ChangeNotifierProvider.value(
    value: authService,
    child: AuthWrapper(
      child: child,
      loginScreen: Container(key: Key('loginScreen')),
    ),
  ));

  return authService;
}

@GenerateMocks([AuthService])
void main() {
  final invalidStateVariants = ValueVariant({
    AuthState.loggedOut(),
    AuthState.error(ErrorType.wrongCredentials),
  });

  testWidgets('calls checkSession when state is initial', (tester) async {
    // ignore: unused_local_variable
    final authService = await renderWithAuthService(
      tester,
    );
  }, skip: true);

  testWidgets('Renders the login screen if the state is not authenticated',
      (tester) async {
    final authService = await renderWithAuthService(tester);

    authService.value = invalidStateVariants.currentValue!;

    expect(find.byKey(Key('loginScreen')), findsOneWidget);
  }, variant: invalidStateVariants, skip: true);

  testWidgets('Renders the given child if the state is authenticated',
      (tester) async {
    const childKey = Key('childToRender');
    final authService =
        await renderWithAuthService(tester, child: Container(key: childKey));

    authService.value = AuthState.authenticated(odooSession);

    expect(find.byKey(childKey), findsOneWidget);
  }, skip: true);
}
