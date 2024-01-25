import 'package:drivn_customer/utils/export.dart';

class RideDetailView extends StatefulWidget {
  final RideShareModel rideShareModel;
  const RideDetailView({super.key, required this.rideShareModel});

  @override
  State<RideDetailView> createState() => _RideDetailViewState();
}

class _RideDetailViewState extends State<RideDetailView> {
  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: CustomeColors.whiteColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            controller: scrollController,
            children: const [RideSharePay()],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.bgdColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: CustomeColors.blackColor,
          ),
        ),
        backgroundColor: CustomeColors.bgdColor,
        title: const Text(
          "Ride Details",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(CustomeImages.ab),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.05,
                ),
                Column(
                  children: [
                    Text(
                      "Joojo McSam",
                      style: TextStyle(
                          fontSize: AppDimentions.mediumFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: CustomeColors.yellowColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          "4.8",
                          style: TextStyle(
                              fontSize: AppDimentions.mediumFontSize,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            const Divider(
              thickness: 1,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
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
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.04,
                    ),
                    ImageIcon(
                      AssetImage(CustomeImages.location),
                      color: CustomeColors.redColor,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.02,
                    ),
                    Text("${widget.rideShareModel.rLocation}"),
                  ],
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
                  "Departure time",
                  style: TextStyle(
                      fontSize: AppDimentions.mediumFontSize,
                      fontWeight: FontWeight.bold),
                ),
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: CustomeColors.primaryColor,
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
            SizedBox(
                height: 40,
                child: TextFormField(
                    decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomeColors.redColor, width: 0.2)),
                  fillColor: CustomeColors.whiteColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: CustomeColors.redColor, width: 0.2)),
                  prefixIcon: ImageIcon(
                    AssetImage(CustomeImages.location1),
                    color: CustomeColors.redColor,
                  ),
                  hintText: "Enter your pickup location",
                ))),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.04,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side:
                        BorderSide(width: 0.2, color: CustomeColors.redColor)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.04,
                      ),
                      const Text("Record pickup location"),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.06,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.mic,
                          color: CustomeColors.redColor,
                        ),
                      )
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
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: CustomeColors.redColor,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.04,
                    ),
                    Text(
                      "2",
                      style: TextStyle(
                          fontSize: AppDimentions.largeFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.add_circle_outline,
                        color: CustomeColors.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.13,
            ),
            const Divider(
              thickness: 0.5,
              color: CustomeColors.blackColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Price",
                      style: TextStyle(
                          color: CustomeColors.blackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$120",
                      style: TextStyle(
                          color: CustomeColors.redColor,
                          fontSize: AppDimentions.mediumFontSize,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          CustomeColors.primaryColor)),
                  onPressed: () {
                    showFlexibleBottomSheet(
                      bottomSheetColor: Colors.transparent,
                      minHeight: 0,
                      initHeight: 0.85,
                      maxHeight: 0.9,
                      context: context,
                      builder: _buildBottomSheet,
                      anchors: [0, 0.85, 0.9],
                      isSafeArea: false,
                    );
                  },
                  child: const Text("Book Now"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
