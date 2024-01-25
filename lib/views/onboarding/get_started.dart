import 'package:drivn_customer/utils/export.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.blackColor,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: AssetImage(CustomeImages.car2), fit: BoxFit.cover),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Text(
                  "Find your rental cars easily.",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 50,
                      height: 1.3,
                      color: CustomeColors.whiteColor),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                ),
                ElevatedButton(
                  onPressed: () => Get.toNamed(AppRouter.onboard),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          CustomeColors.primaryColor)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Get Started", style: TextStyle(color: CustomeColors.whiteColor),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
