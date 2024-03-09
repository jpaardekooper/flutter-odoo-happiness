import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/screens/login_screen.dart';
import 'package:flutter_happiness_poc/services/auth/auth_service.dart';
import 'package:flutter_happiness_poc/widgets/error/loading_screen.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  final Widget? child;
  final Widget? loginScreen;

  AuthWrapper({
    this.child,
    this.loginScreen,
  });

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late Future checkSessionFuture;
  @override
  void initState() {
    super.initState();

    checkSessionFuture =
        Provider.of<AuthService>(context, listen: false).checkSession();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    return FutureBuilder(
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? auth.value.maybeWhen(
                  authenticated: (_) => widget.child!,
                  orElse: () => widget.loginScreen ?? LoginScreen(),
                )
              : LoadingScreen(),
      future: checkSessionFuture,
    );
  }
}
