import 'package:drivn_customer/controllers/rental_controller.dart';
import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class CarDetailView extends StatefulWidget {
  final Vehicle vehicleList;
  const CarDetailView({super.key, required this.vehicleList});

  @override
  State<CarDetailView> createState() => _CarDetailViewState();
}

class _CarDetailViewState extends State<CarDetailView> {
  int isSelected = 0;
  int index = 0;
  int index1 = 0;
  int vAmt = 0;
  int dAmt = 0;
  int total = 0;

  final RentController rentController = Get.put(RentController());

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                color: CustomeColors.whiteColor),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          "${widget.vehicleList.rental!.driver!.firstName} ${widget.vehicleList.rental!.driver!.lastName}",
                          style: TextStyle(
                              fontSize: AppDimentions.mediumFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: CustomeColors.yellowColor,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            "4.8 Rating",
                            style: TextStyle(
                              fontSize: AppDimentions.smallFontSize,
                              // fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: CustomeColors.redColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "₵",
                              style: TextStyle(
                                  color: CustomeColors.whiteColor,
                                  fontSize: 12),
                            ),
                            Text(
                              "${widget.vehicleList.rental!.price}",
                              style: TextStyle(
                                  color: CustomeColors.whiteColor,
                                  fontSize: AppDimentions.mediumFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Text(
                          "per hour",
                          style: TextStyle(
                              color: CustomeColors.whiteColor, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -30,
            left: 10,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(CustomeImages.ab),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> imageIndicators({images, index, BuildContext? context}) {
    List<Container> indicators = [];

    for (int i = 0; i < widget.vehicleList.images.length; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color:
                i == index ? CustomeColors.redColor : CustomeColors.greyColor,
            borderRadius: i == index
                ? BorderRadius.circular(50)
                : BorderRadius.circular(50),
          ),
        ),
      );
    }
    return indicators;
  }

  @override
  void initState() {
    setState(() {
      vAmt = widget.vehicleList.rental?.price != null
          ? widget.vehicleList.rental!.price
          : 0;
      dAmt = widget.vehicleList.rental?.driver?.rate != null
          ? widget.vehicleList.rental!.driver!.rate
          : 0;
      total = vAmt + dAmt;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.bgdColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.bgdColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: CustomeColors.blackColor,
          ),
        ),
        title: const Text(
          "Car Details",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.sizeOf(context).width * 1,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  index1 = value;
                });
              },
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: widget.vehicleList.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.sizeOf(context).width * 1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.vehicleList.images[index].image,
                            ),
                          ),
                        )),
                    widget.vehicleList.rental?.driver != null
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                showFlexibleBottomSheet(
                                  bottomSheetColor: Colors.transparent,
                                  minHeight: 0,
                                  initHeight: 0.2,
                                  maxHeight: 0.3,
                                  context: context,
                                  builder: _buildBottomSheet,
                                  anchors: [0, 0.2, 0.3],
                                  isSafeArea: false,
                                );
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    "Driver: ${widget.vehicleList.rental!.driver!.firstName} ${widget.vehicleList.rental!.driver!.lastName}",
                                    style: TextStyle(
                                        color: CustomeColors.whiteColor,
                                        fontSize: AppDimentions.mediumFontSize),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageIndicators(
                  images: widget.vehicleList.images,
                  context: context,
                  index: index1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                Text(
                  widget.vehicleList.type,
                  style: TextStyle(
                      fontSize: AppDimentions.largeFontSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
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
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          "(200+ Reviews)",
                          style:
                              TextStyle(fontSize: AppDimentions.smallFontSize),
                        )
                      ],
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: CustomeColors.othersColor,
                    ),
                  ],
                ),
                const Divider(),
                Text(
                  "All Features",
                  style: TextStyle(
                      fontSize: AppDimentions.largeFontSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.35,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 3 / 2.8,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                      itemCount: widget.vehicleList.features.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final feature = widget.vehicleList.features[index];
                        final icon = carFeatures[index]["icon"];
                        final info = feature.info;
                        final name = feature.name;

                        return FeatureCard(
                          icon: icon,
                          info: info,
                          name: name,
                          index: index,
                          isSelectedIndex: isSelected,
                          onTap: () {
                            setState(() {
                              isSelected = index;
                            });
                          },
                        );
                      }),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Rate: ",
                          style: TextStyle(
                              color: CustomeColors.blackColor,
                              fontSize: AppDimentions.mediumFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₵$total/Hour",
                          style: TextStyle(
                              color: CustomeColors.redColor,
                              fontSize: AppDimentions.mediumFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              CustomeColors.primaryColor)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DateAndTime(
                                vehicleList: widget.vehicleList, total: total);
                          },
                        ));
                      },
                      child: const Text("Book Now"),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

final List carFeatures = [
  {
    "feature": "Transmission",
    "icon": CustomeImages.translate,
    "detail": "Automatic",
  },
  {
    "feature": "Air Condition",
    "icon": CustomeImages.devices,
    "detail": "Climate Control",
  },
  {
    "feature": "Fuel Type",
    "icon": CustomeImages.gas,
    "detail": "Petol",
  },
  {
    "feature": "Doors",
    "icon": CustomeImages.door,
    "detail": "Normal",
  },
  {
    "feature": "Transmission",
    "icon": CustomeImages.translate,
    "detail": "Automatic",
  },
  {
    "feature": "Air Condition",
    "icon": CustomeImages.devices,
    "detail": "Climate Control",
  },
  {
    "feature": "Fuel Type",
    "icon": CustomeImages.gas,
    "detail": "Petol",
  },
  {
    "feature": "Doors",
    "icon": CustomeImages.door,
    "detail": "Normal",
  },
];

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    this.onTap,
    this.isSelectedIndex,
    this.index,
    this.icon,
    this.info,
    this.name,
  });
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? icon;
  final String? info;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: CustomeColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon!),
              color: CustomeColors.primaryColor,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            Text(
              info!,
              style: TextStyle(
                  fontSize: AppDimentions.mediumFontSize,
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            Text(
              name!,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: CustomeColors.othersColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
