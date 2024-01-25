import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/shared/shared.prefs.manager.dart';
import 'package:drivn_customer/utils/export.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesManager.instance.init();
  setupInterceptorLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'drivn_customer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Roboto",
          scaffoldBackgroundColor: CustomeColors.bgdColor),
      initialRoute: AppRouter.splash,
      getPages: AppRouter.routes,
    );
  }
}
