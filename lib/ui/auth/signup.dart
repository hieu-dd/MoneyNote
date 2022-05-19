import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_note/widgets/gradient_button.dart';
import 'package:money_note/widgets/dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signup() async {
    final userName = _userController.text;
    final password = _passwordController.text;
    if (userName.isNotEmpty && password.isNotEmpty) {
      try {
        final credential =
            await _auth.createUserWithEmailAndPassword(
          email: userName,
          password: password,
        );
        if (credential.user != null) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        GlobalDialog.showAlertError(e.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  child: Text(
                    'auth.sign_up'.tr(),
                    style: theme.textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 60, bottom: 40),
                ),
              ),
              Text(
                'auth.user_name'.tr(),
                style: theme.textTheme.bodySmall,
              ),
              TextField(
                controller: _userController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.login_outlined),
                    label: Text('auth.type_user_name'.tr())),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'auth.password'.tr(),
                style: theme.textTheme.bodySmall,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key_outlined),
                    prefixIconColor: theme.primaryColor,
                    label: Text(
                      'auth.type_password'.tr(),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              GradientButton(
                onPressed: _signup,
                child: Text('auth.sign_up'.tr().toUpperCase()),
                width: double.infinity,
                gradient: LinearGradient(
                  colors: [theme.backgroundColor, theme.primaryColorDark],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
