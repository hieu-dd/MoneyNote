import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_note/widgets/gradient_button.dart';
import 'package:money_note/widgets/dialog.dart';
import 'package:easy_localization/easy_localization.dart';

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
      GlobalDialog.showAlertDialog("Error", error.toString(), null, context);
    }
  }

  void _forgotPassword() {}

  void _login() {}

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
                    'login.title'.tr(),
                    style: theme.textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 60, bottom: 40),
                ),
              ),
              Text(
                'login.user_name'.tr(),
                style: theme.textTheme.bodySmall,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.login_outlined),
                    label: Text('login.type_user_name'.tr())),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'login.password'.tr(),
                style: theme.textTheme.bodySmall,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key_outlined),
                    prefixIconColor: theme.primaryColor,
                    label: Text(
                      'login.type_password'.tr(),
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
                      'login.forgot_password'.tr(),
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
                child: Text('login.title'.tr().toUpperCase()),
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
                'login.sign_in_with'.tr(),
                style: theme.textTheme.bodySmall,
              )),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: _loginWithGoogle,
                child: const Center(
                  child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.facebook,
                          size: 35,
                        ),
                      )),
                ),
              ),
              const Flexible(
                child: Spacer(),
                flex: 1,
              ),
              Center(
                  child: Text(
                'login.sign_up_with'.tr(),
                style: theme.textTheme.bodySmall,
              )),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                'login.sign_up'.tr().toUpperCase(),
                style: theme.textTheme.bodyMedium,
              )),
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
