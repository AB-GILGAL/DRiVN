import 'package:drivn_customer/utils/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pop(context);
      Get.toNamed(AppRouter.getStarted);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      body: Center(
        child: Container(
          height: 100,
          width: MediaQuery.sizeOf(context).width * 1,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(CustomeImages.logo))),
        ),
      ),
    );
  }
}
