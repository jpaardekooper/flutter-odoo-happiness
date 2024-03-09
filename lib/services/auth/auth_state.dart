import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

part 'auth_state.freezed.dart';

enum ErrorType { wrongCredentials, sessionExpired }

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loggedOut() = LoggedOut;
  const factory AuthState.error(ErrorType errorType) = ErrorDetails;
  const factory AuthState.authenticated(OdooSession odooSession) =
      Authenticated;
  const factory AuthState.initial() = Initial;
}
