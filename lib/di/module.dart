import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // provider
  getIt.registerSingleton(ThemeProvider());
}
