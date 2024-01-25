import 'package:drivn_customer/utils/export.dart';

class VerifyUserView extends StatelessWidget {
  const VerifyUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Verified",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: AppDimentions.extraLargeFontSize,
                  fontWeight: FontWeight.bold,
                  color: CustomeColors.whiteColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRouter.index);
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomeColors.blackColor)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Later"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRouter.identityDocs),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(CustomeColors.whiteColor)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Now",
                      style: TextStyle(color: CustomeColors.blackColor),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
