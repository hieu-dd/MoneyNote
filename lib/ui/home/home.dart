import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child:const Icon(Icons.settings),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.setting);
            },
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: InkWell(
            onTap: () {
              context.read<ThemeProvider>().toggleDarkMode();
            },
            child: Text(
              "Home1",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
