import 'package:base_flutter_project/data/sharedpref/shared_preferences_helper.dart';
import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingletonAsync(() async => SharedPreferences.getInstance());
  getIt.registerSingleton(SharedPreferenceHelper(
    await getIt.getAsync<SharedPreferences>(),
  ));
  getIt.registerSingleton(ThemeProvider(getIt.get<SharedPreferenceHelper>()));
}
