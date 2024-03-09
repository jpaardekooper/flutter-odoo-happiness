import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/services/local_storage.dart';
import 'package:flutter_happiness_poc/services/auth/auth_state.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class AuthService extends ValueNotifier<AuthState> {
  final OdooClient client;
  final LocalStorage storage;
  final String database;

  AuthService(this.storage, this.client, this.database)
      : super(AuthState.initial()) {
    addListener(() {
      value.maybeWhen(
        authenticated: (session) async => storage.saveOdooSession(session),
        loggedOut: () async => storage.clearOdooSession(),
        initial: () async => storage.getOdooSession(),
        orElse: () {},
      );
    });
  }

  Future<void> checkSession() async {
    try {
      await client.checkSession();
      value = AuthState.authenticated(client.sessionId!);
    } on OdooSessionExpiredException catch (_) {
      value = AuthState.error(ErrorType.sessionExpired);
    }
  }

  Future<void> signin(String email, String pass) async {
    try {
      await client.authenticate(database, email, pass);
      value = AuthState.authenticated(client.sessionId!);
    } on OdooException catch (_) {
      value = AuthState.error(ErrorType.wrongCredentials);
    }
  }

  Future<void> logout() async {
    await client.destroySession();

    value = AuthState.loggedOut();
  }
}
