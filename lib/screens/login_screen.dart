import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/services/auth/auth.dart';
import 'package:flutter_happiness_poc/widgets/custom_paint/bottom_wave.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late FocusNode usernameNode;
  late FocusNode passwordNode;
  bool _obscureText = true;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    usernameNode = FocusNode();
    passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    usernameNode.dispose();
    passwordNode.dispose();
  }

  _submit() async {
    if (!_formKey.currentState!.validate()) return;

    passwordNode.unfocus();

    await Provider.of<AuthService>(context, listen: false)
        .signin(usernameController.text, passwordController.text);
  }

  //allows to use the tab keys
  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //need to design a happiness logo
  Widget logo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Center(
          child: Text(
        'Happiness Flow',
        style: TextStyle(fontSize: 17),
      )),
    );
  }

  TextFormField inputEmail() {
    return TextFormField(
      controller: usernameController,
      focusNode: usernameNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, usernameNode, passwordNode);
      },
      cursorColor: raisinBlack,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        labelText: 'E-mail',
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      validator: (String? value) {
        return value == null || !value.contains('@') ? 'Invalid email!' : null;
      },
    );
  }

  TextFormField inputPassword() {
    return TextFormField(
      controller: passwordController,
      focusNode: passwordNode,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term) {
        passwordNode.unfocus();
        _submit();
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Password',
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Container(
            color: raisinBlack,
            child: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      obscureText: _obscureText,
      validator: (String? value) {
        return value == null ? 'Please enter a password' : null;
      },
    );
  }

  Widget buttonLogin() {
    return SizedBox(
      key: Key('login'),
      child: ElevatedButton(
        onPressed: _submit,
        child: const Text('Login'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(_size.width, _size.height),
            painter: BottomWave(
              Colors.transparent,
              oceanGreen,
              aquamarine,
            ),
          ),
          Card(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100),
            elevation: 8,
            child: Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                shrinkWrap: true,
                children: [
                  logo(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: inputEmail(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: inputPassword(),
                  ),
                  buttonLogin(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
