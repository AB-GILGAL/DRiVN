import 'package:drivn_customer/utils/export.dart';

class IdentityDocsView extends StatelessWidget {
  const IdentityDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomeColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          Text(
            "Before you rent out a car, let's get you verified.",
            style: TextStyle(
                fontFamily: "Inter",
                fontSize: AppDimentions.largeFontSize,
                fontWeight: FontWeight.bold,
                color: CustomeColors.whiteColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            "We need to ensure it's really you. It's helps us control fraudulent activities and ensures vehicle security.",
            style: TextStyle(
                fontSize: AppDimentions.smallFontSize,
                fontWeight: FontWeight.w500,
                color: CustomeColors.greyColor),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: CustomeColors.whiteColor,
            leading: Icon(
              Icons.file_present_outlined,
              color: CustomeColors.yellowColor,
            ),
            title: Text(
              "Proof of identity",
              style: TextStyle(
                fontSize: AppDimentions.largeFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text("Upload a valid National ID/Passport"),
            trailing: InkWell(
                onTap: () => Get.toNamed(AppRouter.proofId),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: CustomeColors.whiteColor,
            leading: Icon(
              Icons.no_crash_outlined,
              color: CustomeColors.yellowColor,
            ),
            title: Text(
              "Driving document",
              style: TextStyle(
                fontSize: AppDimentions.largeFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: const Text("Upload a valid Driving License"),
            trailing: InkWell(
                onTap: () => Get.toNamed(AppRouter.uploadlicense),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
          ),
          Row(
            children: [
              const Icon(
                Icons.lock_outlined,
                color: CustomeColors.whiteColor,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text:
                        "We process your personal data in accordance with our ",
                    style: const TextStyle(color: CustomeColors.whiteColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Privacy Policy.",
                          style: TextStyle(
                              color: CustomeColors.yellowColor,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
