import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_note/widgets/dialog.dart';
import 'package:money_note/widgets/gradient_button.dart';

import '../../consts/assets.dart';
import '../../utils/routes/routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _loginWithGoogle() async {
    try {
      final googleSignInResult = await _googleSignIn.signIn();
      final googleAuth = await googleSignInResult?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        _auth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        ));
      }
    } catch (error) {
      GlobalDialog.showAlertError(error.toString(), context);
    }
  }

  void _forgotPassword() {
    GlobalDialog.showAlertError('common.continue_development'.tr(), context);
  }

  void _login() async {
    final userName = _userController.text;
    final password = _passwordController.text;
    if (userName.isNotEmpty && password.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: userName, password: password);
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
                    'auth.title'.tr(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: _forgotPassword,
                    child: Text(
                      'auth.forgot_password'.tr(),
                      style: theme.textTheme.caption,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GradientButton(
                onPressed: _login,
                child: Text('auth.title'.tr().toUpperCase()),
                width: double.infinity,
                gradient: LinearGradient(
                  colors: [theme.backgroundColor, theme.primaryColorDark],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                'auth.sign_in_with'.tr(),
                style: theme.textTheme.bodySmall,
              )),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: _loginWithGoogle,
                child: Center(
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        Assets.iconGoogle,
                        height: 40.0,
                        width: 40.0,
                        color: theme.primaryColorDark,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              const Flexible(
                child: Spacer(),
                flex: 1,
              ),
              Center(
                  child: Text(
                'auth.sign_up_with'.tr(),
                style: theme.textTheme.bodySmall,
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.signup);
                  },
                  child: Text(
                    'auth.sign_up'.tr().toUpperCase(),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
