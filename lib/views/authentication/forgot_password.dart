import 'package:drivn_customer/utils/export.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool isEmail = true;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.primaryColor,
        title: const Text("Forgot password"),
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
            isEmail
                ? FormItem(
                    name: "Email",
                    controller: textController,
                    hintText: "email@example.com")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telephone",
                        style: TextStyle(
                            color: CustomeColors.yellowColor,
                            fontSize: AppDimentions.mediumFontSize),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: IntlPhoneField(
                          controller: textController,
                          style:
                              const TextStyle(color: CustomeColors.whiteColor),
                          dropdownIcon: const Icon(
                            Icons.arrow_drop_down,
                            color: CustomeColors.whiteColor,
                          ),
                          dropdownTextStyle:
                              const TextStyle(color: CustomeColors.whiteColor),
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
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to:  ${country.name}');
                          },
                        ),
                      ),
                    ],
                  ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isEmail = !isEmail;
                  });
                },
                child: Text(
                  isEmail ? "Use phone number" : "Use email address",
                  style: TextStyle(
                      color: CustomeColors.yellowColor,
                      fontSize: AppDimentions.mediumFontSize),
                ),
              ),
            ),
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
                      Get.toNamed(AppRouter.resetPwd);
                    },
                  );
                },
                title: "Send request",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
