import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_note/utils/ext/string_ext.dart';

class AccountScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  void _logout() {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = _auth.currentUser!;
    final key = (user.displayName ?? user.email ?? user.phoneNumber ?? "")[0]
        .toUpperCase();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'account.common'.tr().capitalize(),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                user.photoURL?.isNotEmpty == true
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(
                          user.photoURL ?? "",
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.fill,
                        ),
                      )
                    : SizedBox(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          backgroundColor: theme.primaryColorDark,
                          child: Text(
                            key,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                if (user.displayName?.isNotEmpty == true)
                  Text(
                    user.displayName!,
                    style: theme.textTheme.headlineSmall,
                  ),
                Text(
                  user.email ?? user.phoneNumber ?? "",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: TextButton(
              onPressed: _logout,
              child: Text('account.sign_out'.tr().capitalize()),
            ),
          ),
          const SizedBox(height: 40)
        ],
      ),
    );
  }
}
