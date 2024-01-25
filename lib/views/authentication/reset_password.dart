import 'package:drivn_customer/utils/export.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  bool obsecureText = true;
  bool obsecureText1 = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.primaryColor,
        title: const Text("Reset password"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Enter phone number or email address registered with drivn_customer app to reset your password.",
              style: TextStyle(
                  fontSize: AppDimentions.mediumFontSize,
                  color: CustomeColors.whiteColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            FormItem(
                name: "Old password",
                controller: passwordController,
                hintText: "**********",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecureText = !obsecureText;
                    });
                  },
                  child: obsecureText
                      ? const Icon(
                          Icons.visibility_off,
                          color: CustomeColors.whiteColor,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: CustomeColors.whiteColor,
                        ),
                ),
                obscureText: obsecureText),
            FormItem(
                name: "New password",
                controller: confirmPasswordController,
                hintText: "**********",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obsecureText1 = !obsecureText1;
                    });
                  },
                  child: obsecureText1
                      ? const Icon(
                          Icons.visibility_off,
                          color: CustomeColors.whiteColor,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: CustomeColors.whiteColor,
                        ),
                ),
                obscureText: obsecureText1),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CommonButton(
                bgd: CustomeColors.blackColor,
                onPressed: () {
                  loadingBar(context);
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      Navigator.pop(context);
                      _showDialog(context).show();
                    },
                  );
                },
                title: "Reset password",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AwesomeDialog _showDialog(BuildContext context) {
  return AwesomeDialog(
    btnOk: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor:
                  MaterialStateProperty.all(CustomeColors.primaryColor)),
          onPressed: () {},
          child: const Text("Continue")),
    ),
    btnOkColor: CustomeColors.primaryColor,
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: Column(
      children: [
        Container(
          height: 100,
          width: 130,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CustomeImages.reset), fit: BoxFit.fill)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        Text(
          'Success',
          style: TextStyle(
              color: CustomeColors.blackColor,
              fontSize: AppDimentions.largeFontSize,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        Text(
          'Password successfully changed.',
          style: TextStyle(
              color: CustomeColors.greyColor,
              fontSize: AppDimentions.mediumFontSize,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    btnOkOnPress: () => Get.toNamed(AppRouter.login),
  );
}
