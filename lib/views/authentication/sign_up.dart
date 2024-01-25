import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  bool obsecureText = true;
  bool obsecureText1 = true;
  String? selectedUser;
  String dialCode = "+233";

  RegistrationController registrationController =
      Get.put(RegistrationController());

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
                  child: Column(children: [
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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

                          const Center(
                              child: Text(
                            "Create account to get started.",
                            style: TextStyle(
                                color: CustomeColors.whiteColor, fontSize: 20),
                          )),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                          Form(
                            key: formKey,
                            child: Column(children: [
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 100),
                                slidingBeginOffset: const Offset(0.00, 0.34),
                                child: FormItem(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter last name";
                                      } else {
                                        return null;
                                      }
                                    },
                                    name: "Last name",
                                    controller:
                                        registrationController.lnameController,
                                    hintText: "Doe"),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 150),
                                slidingBeginOffset: const Offset(0.00, 0.34),
                                child: FormItem(
                                    name: "First name",
                                    controller:
                                        registrationController.fnameController,
                                    hintText: "John"),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 250),
                                slidingBeginOffset: const Offset(0.00, 0.34),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Telephone",
                                      style: TextStyle(
                                          color: CustomeColors.yellowColor,
                                          fontSize:
                                              AppDimentions.mediumFontSize),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: IntlPhoneField(
                                        cursorColor: CustomeColors.whiteColor,
                                        controller: registrationController
                                            .phoneController,
                                        style: const TextStyle(
                                            color: CustomeColors.whiteColor),
                                        dropdownIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomeColors.whiteColor,
                                        ),
                                        dropdownTextStyle: const TextStyle(
                                            color: CustomeColors.whiteColor),
                                        decoration: InputDecoration(
                                          counterStyle: const TextStyle(
                                              color: CustomeColors.whiteColor),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color:
                                                    CustomeColors.whiteColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color:
                                                    CustomeColors.whiteColor),
                                          ),
                                        ),
                                        initialCountryCode: 'GH',
                                        languageCode: "en",
                                        onChanged: (phone) {},
                                        onCountryChanged: (country) {
                                          dialCode = "+${country.dialCode}";
                                          print(dialCode);
                                          registrationController
                                                  .countryDialCode =
                                              "+${country.dialCode}";
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 300),
                                slidingBeginOffset: const Offset(0.00, 0.34),
                                child: FormItem(
                                    name: "Password",
                                    controller: registrationController
                                        .passwordController,
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
                                delay: const Duration(milliseconds: 350),
                                slidingBeginOffset: const Offset(0.00, 0.34),
                                child: FormItem(
                                    name: "Confirm password",
                                    controller: registrationController
                                        .confirmPasswordController,
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
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.03,
                              ),
                            ]),
                          ),
                          Center(
                            child: SizedBox(
                                width: 250,
                                child: DelayedDisplay(
                                  delay: const Duration(milliseconds: 450),
                                  slidingBeginOffset: const Offset(0.00, 0.34),
                                  child: CommonButton(
                                    bgd: CustomeColors.blackColor,
                                    onPressed: ()async {
                                      registrationController.context = context;
                                      loadingBar(context);
                                     
                                       await   registrationController
                                              .registerWithPhone()
                                              .then((value) =>
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        VerificationPage(
                                                      phoneNumber:
                                                          '$dialCode${registrationController.phoneController.text.trim()}',
                                                      password:
                                                          registrationController
                                                              .passwordController
                                                              .text
                                                              .trim(),
                                                    ),
                                                  )
                                                      )
                                                  );    
                                       
                                    },
                                    title: "Sign Up",
                                  ),
                                )),
                          ),

                          ////////////////////
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        color: CustomeColors.whiteColor),
                                  ),
                                  SizedBox(
                                    width: AppDimentions.paddingSmallSize,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.toNamed(AppRouter.login),
                                    child: Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: CustomeColors.yellowColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  AppDimentions.smallFontSize),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.01,
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
                  ])));
        }),
      ),
    );
  }
}

List user = [
  "Client",
  "Driver",
];
