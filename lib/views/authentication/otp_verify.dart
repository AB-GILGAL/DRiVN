import 'package:drivn_customer/controllers/login.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class VerificationPage extends StatefulWidget {
  final String? phoneNumber;
  final String? password;
  const VerificationPage({
    super.key,
    this.phoneNumber,
    this.password,
  });

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String? otpCode;
  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Enter OTP ",
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: AppDimentions.extraLargeFontSize,
                    fontWeight: FontWeight.bold,
                    color: CustomeColors.whiteColor),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              const Text(
                "Kindly enter the 4 digit code sent to your mail address.",
                style: TextStyle(color: CustomeColors.whiteColor),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OtpTextField(
                    numberOfFields: 4,
                    borderColor: CustomeColors.whiteColor,
                    fieldWidth: 65,
                    focusedBorderColor: CustomeColors.yellowColor,
                    cursorColor: CustomeColors.whiteColor,
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: CustomeColors.whiteColor),
                    borderRadius: BorderRadius.circular(15),

                    //set to true to show as box or false to show as dash
                    showFieldAsBox: true,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otpCode = verificationCode;
                      });
                    }, // end onSubmit
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  CommonButton(
                      bgd: CustomeColors.blackColor,
                      title: "Continue",
                      onPressed: () {
                        registrationController.context = context;
                        loadingBar(context);
                        Future.delayed(
                          const Duration(seconds: 4),
                          () async {
                            await registrationController
                                .verifyOTP(otp: otpCode)
                                .then((value) =>
                                    LoginController().loginWithPhoneNoRoute(body: {
                                      "username": widget.phoneNumber,
                                      "password": widget.password,
                                    }));
                          },
                        );
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive code?",
                        style: TextStyle(color: CustomeColors.whiteColor),
                      ),
                      SizedBox(
                        width: AppDimentions.paddingSmallSize,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRouter.otp),
                        child: Text(
                          "Resend Code",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: CustomeColors.yellowColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimentions.mediumFontSize),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
