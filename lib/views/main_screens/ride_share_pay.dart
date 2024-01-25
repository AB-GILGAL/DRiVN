import 'package:drivn_customer/utils/export.dart';

class RideSharePay extends StatefulWidget {
  const RideSharePay({super.key});

  @override
  State<RideSharePay> createState() => _RideSharePayState();
}

class _RideSharePayState extends State<RideSharePay> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Destination",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 0.2, color: CustomeColors.redColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage(CustomeImages.location),
                        color: CustomeColors.blackColor,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                      Text(
                        "Dome, Accra",
                        style: TextStyle(
                            fontSize: AppDimentions.mediumFontSize,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Text("0.5km")
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 0.2, color: CustomeColors.redColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Departure time",
                    style: TextStyle(
                        fontSize: AppDimentions.mediumFontSize,
                        fontWeight: FontWeight.w400),
                  ),
                  Material(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: CustomeColors.redColor,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: Text(
                        "07:20",
                        style: TextStyle(color: CustomeColors.whiteColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Pick-up location",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 0.2, color: CustomeColors.redColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Row(
                children: [
                  ImageIcon(
                    AssetImage(CustomeImages.location),
                    color: CustomeColors.blackColor,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  Text(
                    "Circle, Accra",
                    style: TextStyle(
                        fontSize: AppDimentions.mediumFontSize,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: Material(
              color: CustomeColors.redColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 0.2, color: CustomeColors.redColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.play_circle_outline,
                        color: CustomeColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.06,
                    ),
                    const Text(
                      "Play pick up location",
                      style: TextStyle(color: CustomeColors.whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Number of seats",
                style: TextStyle(
                    fontSize: AppDimentions.mediumFontSize,
                    fontWeight: FontWeight.bold),
              ),
              Material(
                color: CustomeColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text(
                    "2",
                    style: TextStyle(color: CustomeColors.whiteColor),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Payment",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(width: 0.2, color: CustomeColors.redColor)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 45,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(CustomeImages.ntm),
                            ),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.04,
                      ),
                      Column(
                        children: [
                          Text(
                            "Mobile Money",
                            style: TextStyle(
                                fontSize: AppDimentions.smallFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.015,
                          ),
                          Text(
                            "******2546",
                            style: TextStyle(
                                fontSize: AppDimentions.smallFontSize,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all(CustomeColors.primaryColor)),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Pay Now",
                        style: TextStyle(
                            fontSize: AppDimentions.mediumFontSize,
                            fontWeight: FontWeight.bold,
                            color: CustomeColors.whiteColor),
                      ),
                      const Text("|"),
                      Text(
                        "  \$200  ",
                        style: TextStyle(
                            fontSize: AppDimentions.mediumFontSize,
                            fontWeight: FontWeight.bold,
                            color: CustomeColors.whiteColor),
                      )
                    ],
                  ),
                )),
          )
        ],
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
          child: const Text("Done")),
    ),
    btnOkColor: CustomeColors.primaryColor,
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    body: Column(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage(CustomeImages.confirm), fit: BoxFit.cover)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.015,
        ),
        RichText(
            text: TextSpan(children: <InlineSpan>[
          TextSpan(
            text: "Your Booking is ",
            style: TextStyle(
                color: CustomeColors.blackColor,
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: "Confirmed",
            style: TextStyle(
                color: CustomeColors.primaryColor,
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.w600),
          ),
        ])),
      ],
    ),
    btnOkOnPress: () => Get.toNamed(AppRouter.login),
  );
}
