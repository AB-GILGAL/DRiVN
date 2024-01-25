import 'package:drivn_customer/components/google_login_btn.dart';
import 'package:drivn_customer/controllers/login.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  bool logInWithEmail = true;
  bool obsecureText = true;

  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: boxConstraints.maxHeight,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimentions.paddingLargeSize),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 50),
                    slidingBeginOffset: const Offset(0.00, 0.34),
                    child: Container(
                      height: 100,
                      width: MediaQuery.sizeOf(context).width * 1,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(CustomeImages.logo))),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 100),
                    slidingBeginOffset: const Offset(0.00, 0.34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Telephone",
                          style: TextStyle(
                              color: CustomeColors.yellowColor,
                              fontSize: AppDimentions.smallFontSize),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: IntlPhoneField(
                            cursorColor: CustomeColors.whiteColor,
                            controller: loginController.phoneController,
                            style: const TextStyle(
                                color: CustomeColors.whiteColor),
                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: CustomeColors.whiteColor,
                            ),
                            dropdownTextStyle: const TextStyle(
                              color: CustomeColors.whiteColor,
                            ),
                            decoration: InputDecoration(
                              counterStyle: const TextStyle(
                                  color: CustomeColors.whiteColor),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: CustomeColors.whiteColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: CustomeColors.whiteColor),
                              ),
                            ),
                            initialCountryCode: 'GH',
                            languageCode: "en",
                            onChanged: (phone) {},
                            onCountryChanged: (country) {
                              loginController.countryDialCode =
                                  "+${country.dialCode}";
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 150),
                    slidingBeginOffset: const Offset(0.00, 0.34),
                    child: FormItem(
                        name: "Password",
                        controller: loginController.passwordController,
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
                  ),
                  DelayedDisplay(
                      delay: const Duration(milliseconds: 200),
                      slidingBeginOffset: const Offset(0.00, 0.34),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Get.toNamed(AppRouter.forgotPwd),
                          child: Text(
                            "Forget password",
                            style: TextStyle(
                                color: CustomeColors.yellowColor,
                                fontSize: AppDimentions.smallFontSize),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .02,
                  ),
                  Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: DelayedDisplay(
                          delay: const Duration(milliseconds: 250),
                          slidingBeginOffset: const Offset(0.00, 0.34),
                          child: CommonButton(
                            bgd: CustomeColors.blackColor,
                            onPressed: () async {
                              loadingBar(context);
                              
                               await   loginController.loginWithPhone(context);
                              if(context.mounted){  Navigator.pop(context);}

                                  // Get.toNamed(AppRouter.index);
                                
                            },
                            title: "Login",
                          ),
                        )),
                  ),

                  ////////////////////
                  DelayedDisplay(
                    delay: const Duration(milliseconds: 300),
                    slidingBeginOffset: const Offset(0.00, 0.34),
                    child: Column(
                      children: [
                        SizedBox(height: AppDimentions.paddingLargeSize),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: CustomeColors.whiteColor),
                            ),
                            SizedBox(
                              width: AppDimentions.paddingMediumSize,
                            ),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRouter.signUp),
                              child: Text(
                                "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: CustomeColors.yellowColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppDimentions.smallFontSize),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                  DelayedDisplay(
                      delay: const Duration(milliseconds: 350),
                      slidingBeginOffset: const Offset(0.00, 0.34),
                      child: GoogleButton(title: "Sign-In", onTap: () {})),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Future<dynamic> loadingBar(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
              backgroundColor: CustomeColors.whiteColor.withOpacity(0.0),
              elevation: 0.0,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.inkDrop(
                      color: CustomeColors.yellowColor, size: 60),
                  SizedBox(
                    height: AppDimentions.paddingMediumSize,
                  ),
                  Center(
                    child: Text(
                      "PLEASE WAIT...",
                      style: TextStyle(
                          color: CustomeColors.yellowColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        );
      });
}
