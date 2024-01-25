import 'package:drivn_customer/controllers/rental_controller.dart';
import 'package:drivn_customer/controllers/type_controller.dart';
import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? isSelected;
  int isSelected1 = 0;
  int index = 0;
  String? city;
  String? country;
  List _foundRide = [];
  String? searchType;
  bool withDriver = false;

  TextEditingController searchController = TextEditingController();

  TextEditingController locationSearchController = TextEditingController();

  final TypeController typeController =
      Get.put(TypeController(), permanent: true);
  final RentController rentController = Get.put(RentController());

  // //this function help the stream builder to operate.
  final _streamController = StreamController<List<Vehicle>>.broadcast();
  late Future<List<Vehicle>> vehicles;
  late Timer _timer;

  void fetchAllVehicles() async {
    vehicles = Get.find<RentController>().fetchAllVehicles();
    if (mounted) {
      var streamData = await vehicles;
      if (!_streamController.isClosed) {
        _streamController.add(streamData);
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchAllVehicles();
    });

    // fetchVehicles();
    // getAddress(
    //     globalController.getLat().value, globalController.getLng().value);
    _foundRide = searchRideShare;
    typeController.fetchAllTypes();
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = searchRideShare;
    } else {
      results = searchRideShare
          .where((crs) => crs["location"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundRide = results;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: CustomeColors.bgdColor,
        appBar: AppBar(
          backgroundColor: CustomeColors.bgdColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomeColors.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: ImageIcon(
                      AssetImage(
                        CustomeImages.location,
                      ),
                      color: CustomeColors.whiteColor,
                      size: 18,
                    ),
                  )),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.02,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: TextFormField(
                  onTap: () {
                    Get.toNamed(AppRouter.places);
                  },
                  onChanged: (v) {
                    setState(() {
                      rentController.rentLocation.value = v;
                      rentController.fetchAllVehicles();
                    });
                  },
                  readOnly: true,
                  controller: TextEditingController(
                      text: rentController.rentLocation.value),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search location",
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRouter.places);
                },
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: CustomeColors.blackColor,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.grid_view,
                color: CustomeColors.primaryColor,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.07,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 0),
                    shrinkWrap: true,
                    itemCount: bookingCat.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return BookingCategories(
                        title: bookingCat[index]['title'],
                        index: index,
                        isSelectedIndex: isSelected1,
                        onTap: () {
                          setState(() {
                            isSelected1 = index;
                          });
                        },
                      );
                    }),
              ),
              isSelected1 == 0
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.74,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            child: Obx(() {
                              return typeController.typeList.isNotEmpty
                                  ? ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.025,
                                          ),
                                      shrinkWrap: true,
                                      itemCount: typeController.typeList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final type =
                                            typeController.typeList[index];
                                        final name = type.name;
                                        return SearchCategoriesCompnent(
                                            title: name,
                                            index: index,
                                            isSelectedIndex: isSelected,
                                            onTap: () {
                                              setState(() {
                                                isSelected = index;
                                                searchType = name;
                                                rentController
                                                    .selectedType.value = name;
                                                rentController
                                                    .fetchAllVehicles();
                                              });
                                            });
                                      })
                                  : const Center(
                                      child: CircularProgressIndicator());
                            }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Switch(
                                      activeColor: CustomeColors.redColor,
                                      value: Get.find<RentController>()
                                          .withDriver
                                          .value,
                                      onChanged: (newValue) {
                                        Get.find<RentController>()
                                            .setWithDriver(newValue);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.015,
                                  ),
                                  const Text(
                                    "With Driver",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(AppRouter.cBrand),
                                child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: CustomeColors.greyColor),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                      color: CustomeColors.whiteColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.search,
                                        color: CustomeColors.redColor,
                                        size: 18,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                          Expanded(
                            child: StreamBuilder<List<Vehicle>>(
                              stream: _streamController
                                  .stream, // Replace with your actual vehicle stream
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (snapshot.hasData &&
                                    snapshot.data!.isNotEmpty) {
                                  return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 300,
                                      mainAxisExtent: 190,
                                      // childAspectRatio: 3 / 3.7,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 20,
                                    ),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      final vehicle = snapshot.data![index];
                                      final images = vehicle.images[0].image;
                                      final type = vehicle.type;
                                      final brand = vehicle.brand;
                                      final rate = vehicle.rental!.price;
                                      //rental vehicle card
                                      return RentalCardCategory(
                                        images: images.toString(),
                                        model: type,
                                        brand: brand,
                                        rate: rate,
                                        index: index,
                                        isSelectedIndex: isSelected,
                                        onTap: () {
                                          setState(() {
                                            isSelected = index;
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return CarDetailView(
                                                  vehicleList: Vehicle(
                                                    availability:
                                                        vehicle.availability,
                                                    booked: vehicle.booked,
                                                    brand: vehicle.brand,
                                                    createdAt:
                                                        vehicle.createdAt,
                                                    documents:
                                                        vehicle.documents,
                                                    id: vehicle.id,
                                                    images: vehicle.images,
                                                    owner: vehicle.owner,
                                                    type: vehicle.type,
                                                    updatedAt:
                                                        vehicle.updatedAt,
                                                    features: vehicle.features,
                                                    rental: vehicle.rental,
                                                  ),
                                                );
                                              },
                                            ));
                                          });
                                        },
                                      );
                                    },
                                  );
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No vehicles available'));
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.02,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  _runFilter(value);
                                },
                                controller: searchController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    focusColor: CustomeColors.greyColor,
                                    hintText: "Search for destination",
                                    filled: true,
                                    fillColor: CustomeColors.whiteColor,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, right: 5),
                                      child: ImageIcon(
                                          AssetImage(CustomeImages.location)),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                              shrinkWrap: true,
                              itemCount: _foundRide.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final location = _foundRide[index]['location'];
                                final image = _foundRide[index]['image'];
                                return SearchRideShareCard(
                                    location: location,
                                    image: image,
                                    index: index,
                                    isSelectedIndex: isSelected,
                                    onTap: () {
                                      setState(
                                        () {
                                          isSelected = index;
                                        },
                                      );
                                    });
                              }),
                        )
                      ],
                    ),
            ]),
          ),
        )));
  }
}

final List bookingCat = [
  {
    "title": "Rental",
  },
  {
    "title": "Ride Sharing",
  },
];

final List bookingSum = [
  {
    "title": "Current Booking",
  },
  {
    "title": "Booking History",
  },
];

final List search = [
  {
    "title": "Luxury Car",
  },
  {
    "title": "Family Car",
  },
  {
    "title": "Popular",
  },
  {
    "title": "Free",
  },
  {
    "title": "For you",
  },
  {
    "title": "Discounted",
  },
  {
    "title": "Promo",
  },
  {
    "title": "Short  course",
  },
];

final List rentalCard = [
  {
    "model": "Hyundai ix 35",
    "image": CustomeImages.car1,
    "brand": "Hyundai",
    "rate": 120,
  },
  {
    "model": "Toyota",
    "image": CustomeImages.car2,
    "brand": "Toyota",
    "rate": 135,
  },
  {
    "model": "Ford",
    "image": CustomeImages.car3,
    "brand": "Ford",
    "rate": 100,
  },
  {
    "model": "Bugatti",
    "image": CustomeImages.car4,
    "brand": "Bugatti",
    "rate": 160,
  },
  {
    "model": "Lamborghini",
    "image": CustomeImages.car1,
    "brand": "Lamborghini",
    "rate": 200,
  },
  {
    "model": "BMW",
    "image": CustomeImages.car2,
    "brand": "BMW",
    "rate": 140,
  },
  {
    "model": "Hunda",
    "image": CustomeImages.car3,
    "brand": "Hunda",
    "rate": 170,
  },
  {
    "model": "VW",
    "image": CustomeImages.car4,
    "brand": "VW",
    "rate": 115,
  },
];

final List searchRideShare = [
  {
    "location": "Adenta",
    "image": CustomeImages.car1,
  },
  {
    "location": "Dome Pillar 2",
    "image": CustomeImages.car2,
  },
  {
    "location": "Weija",
    "image": CustomeImages.car3,
  },
  {
    "location": "Kasoa",
    "image": CustomeImages.car4,
  },
  {
    "location": "Lapaz",
    "image": CustomeImages.car1,
  },
  {
    "location": "Circle",
    "image": CustomeImages.car2,
  },
  {
    "location": "Dome Pillar 2",
    "image": CustomeImages.car3,
  },
  {
    "location": "Tema",
    "image": CustomeImages.car4,
  },
];

class SearchCategoriesCompnent extends StatelessWidget {
  const SearchCategoriesCompnent(
      {super.key, this.onTap, this.isSelectedIndex, this.index, this.title});
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.04,
            // width: MediaQuery.sizeOf(context).width * 0.25,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: CustomeColors.whiteColor,
                border: isSelectedIndex == index
                    ? Border.all(
                        color: CustomeColors.primaryColor,
                      )
                    : Border.all(
                        color: CustomeColors.othersColor,
                      ),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelectedIndex == index
                        ? CustomeColors.primaryColor
                        : CustomeColors.othersColor),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class FilterCategoriesCompnent extends StatelessWidget {
  const FilterCategoriesCompnent(
      {super.key, this.onTap, this.isSelectedIndex, this.index, this.title});
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.04,
            // width: MediaQuery.sizeOf(context).width * 0.25,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isSelectedIndex == index
                    ? CustomeColors.primaryColor
                    : CustomeColors.whiteColor,
                border: isSelectedIndex == index
                    ? Border.all(
                        color: CustomeColors.primaryColor,
                      )
                    : Border.all(
                        color: CustomeColors.othersColor,
                      ),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title!,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isSelectedIndex == index
                        ? CustomeColors.whiteColor
                        : CustomeColors.othersColor),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class BookingCategories extends StatelessWidget {
  const BookingCategories(
      {super.key, this.onTap, this.isSelectedIndex, this.index, this.title});
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.04,
            width: MediaQuery.sizeOf(context).width * 0.45,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isSelectedIndex == index
                    ? CustomeColors.primaryColor
                    : CustomeColors.whiteColor,
                border: Border.all(
                  color: CustomeColors.yellowColor,
                ),
                borderRadius: index == 0
                    ? const BorderRadius.horizontal(left: Radius.circular(7))
                    : const BorderRadius.horizontal(right: Radius.circular(7))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                title!,
                style: TextStyle(
                    fontSize: AppDimentions.smallFontSize,
                    fontWeight: FontWeight.w500,
                    color: isSelectedIndex == index
                        ? CustomeColors.whiteColor
                        : CustomeColors.primaryColor),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class RentalCardCategory extends StatelessWidget {
  RentalCardCategory(
      {super.key,
      this.onTap,
      this.isSelectedIndex,
      this.index,
      this.images,
      this.model,
      this.brand,
      this.rate});
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? images;
  final String? model;
  final String? brand;
  final int? rate;
  final RentController rentController = Get.put(RentController());
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.13,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(images!),
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10))),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!,
                  style: TextStyle(
                      fontSize: AppDimentions.paddingLargeSize,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.002,
                ),
                Text(
                  brand!,
                  style: const TextStyle(
                      color: CustomeColors.othersColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "¢${rate.toString()}/hour",
                      style: TextStyle(
                          fontSize: AppDimentions.mediumFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: CustomeColors.primaryColor,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.arrow_forward,
                              color: CustomeColors.whiteColor,
                              size: 18,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchRideShareCard extends StatelessWidget {
  const SearchRideShareCard({
    super.key,
    this.onTap,
    this.isSelectedIndex,
    this.index,
    this.image,
    this.location,
  });
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? image;
  final String? location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return RideDetailView(
              rideShareModel: RideShareModel(rLocation: location, rImg: image));
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(image!),
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.01,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .52,
                        decoration: BoxDecoration(
                            color: CustomeColors.bgdColor,
                            border: Border.all(color: CustomeColors.greyColor),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage(CustomeImages.location),
                                color: CustomeColors.primaryColor,
                              ),
                              Text(
                                location!,
                                style: TextStyle(
                                    fontSize: AppDimentions.smallFontSize,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      Row(
                        children: [
                          Text(
                            "\$ 2.45",
                            style: TextStyle(
                                fontSize: AppDimentions.extraSmallFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .1,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.usb_rounded,
                                size: 13,
                              ),
                              Text(
                                "0/3",
                                style: TextStyle(
                                    fontSize: AppDimentions.extraSmallFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .1,
                          ),
                          Text(
                            "07:20",
                            style: TextStyle(
                                fontSize: AppDimentions.extraSmallFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> getTopSearches() {
  List<Widget> topSearches = [
    ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      shrinkWrap: true,
      itemCount: searchRideShare.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return SearchRideShareCard(
            location: searchRideShare[index]['location'],
            image: searchRideShare[index]['image'],
            index: index,
            // isSelectedIndex: isSelected1,
            onTap: () {
              // setState(() {
              //   isSelected1 = index;
            });
      },
    )
  ];
  return topSearches;
}
