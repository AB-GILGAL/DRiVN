import 'package:drivn_customer/controllers/booked_vehicle_controller.dart';
import 'package:drivn_customer/controllers/past_bookings.controller.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class BookView extends StatefulWidget {
  const BookView({super.key});

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  int isSelected = 0;
  int isSelected1 = 0;
  int rentDuration = 0;
  Duration duration = Duration(hours: 2);
  Timer? timer;
  final BookedVehiclesController bookedVehiclesController =
      Get.put(BookedVehiclesController());
  final PastBookingController pastBookingController =
      Get.put(PastBookingController());

  void countDown() {
    final decreaseSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds - decreaseSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => countDown());
  }

  Widget buildTimer() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$hours:$minutes:$seconds",
      style: TextStyle(
          fontSize: AppDimentions.smallFontSize, fontWeight: FontWeight.w500),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomeColors.bgdColor,
        title: const Text(
          "Bookings",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
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
                      title: bookingSum[index]['title'],
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
                ? Obx(() {
                    return bookedVehiclesController.bookedVehicleList.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                shrinkWrap: true,
                                itemCount: bookedVehiclesController
                                    .bookedVehicleList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final current = bookedVehiclesController
                                      .bookedVehicleList[index];
                                  final img =
                                      current.vehicleRequests?.isNotEmpty ==
                                              true
                                          ? current.vehicleRequests![0].vehicle!
                                              .images[0].image
                                          : "";
                                  final carId = current
                                              .vehicleRequests?.isNotEmpty ==
                                          true
                                      ? current.vehicleRequests![0].vehicle!.id
                                      : "";
                                  final pickUpLocation =
                                      current.rental.customerLocation;
                                  final price = current.rental.transactions
                                              ?.isNotEmpty ==
                                          true
                                      ? current.rental.transactions![0].amount
                                      : 0;
                                  return CurrentBooking(
                                    index: index,
                                    isSelectedIndex: isSelected,
                                    onTap: () {
                                      setState(() {
                                        isSelected = index;
                                      });
                                    },
                                    images: img,
                                    carId: carId.toString(),
                                    pickUpLocation: pickUpLocation,
                                    timeRemaining: buildTimer(),
                                    price: price,
                                  );
                                }),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: const Center(
                              child: Text("No current booking available."),
                            ),
                          );
                  })
                : Obx(() {
                    return pastBookingController.pastBookingList.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.74,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                shrinkWrap: true,
                                itemCount: pastBookingController
                                    .pastBookingList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final past = pastBookingController
                                      .pastBookingList[index];
                                  final img =
                                      past.vehicleRequests?.isNotEmpty == true
                                          ? past.vehicleRequests![0].vehicle!
                                              .images[0].image
                                          : "";
                                  final carId =
                                      past.vehicleRequests?.isNotEmpty == true
                                          ? past.vehicleRequests![0].vehicle!.id
                                          : "";
                                  final pickUp = past.rental.customerLocation;
                                  final tripStart = past.tripStartedAt;
                                  final tripEnd = past.tripEndedAt;
                                  final tripDuration = past.bookingStatus;
                                  final tripCost =
                                      past.rental.transactions?.isNotEmpty ==
                                              true
                                          ? past.rental.transactions![0].amount
                                          : 0;

                                  return PastBooking(
                                    index: index,
                                    isSelectedIndex: isSelected,
                                    onTap: () {
                                      setState(() {
                                        isSelected = index;
                                      });
                                    },
                                    images: img,
                                    carId: carId.toString(),
                                    pickUpLocation: pickUp,
                                    tripStart: tripStart,
                                    tripEnd: tripEnd,
                                    tripDuration: tripDuration,
                                    tripCost: tripCost.toString(),
                                  );
                                }),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.74,
                            child: const Center(
                              child: Text("No booking history available."),
                            ),
                          );
                  }),
          ],
        ),
      ),
    );
  }
}

class CurrentBooking extends StatelessWidget {
  const CurrentBooking(
      {super.key,
      this.onTap,
      this.isSelectedIndex,
      this.index,
      this.images,
      this.carId,
      this.pickUpLocation,
      this.timeRemaining,
      this.price});

  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? images;
  final String? carId;
  final String? pickUpLocation;
  final Widget? timeRemaining;
  final int? price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(images!),
                    ),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, bottom: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              CustomeColors.redColor)),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("More"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.018,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: AppDimentions.mediumFontSize,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Car ID",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      carId!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pick-Up Location",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      pickUpLocation!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time Remaining",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    timeRemaining!
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      price.toString(),
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PastBooking extends StatelessWidget {
  const PastBooking(
      {super.key,
      this.onTap,
      this.isSelectedIndex,
      this.index,
      this.images,
      this.carId,
      this.pickUpLocation,
      this.tripStart,
      this.tripEnd,
      this.tripDuration,
      this.tripCost});

  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? images;
  final String? tripStart;
  final String? tripEnd;
  final String? carId;
  final String? pickUpLocation;
  final String? tripDuration;
  final String? tripCost;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(images!),
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Car ID",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      carId!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pick-Up Location",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      pickUpLocation!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Start",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      tripStart!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip End",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      tripEnd!,
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Duration",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      tripDuration.toString(),
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trip Cost",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "\$ ${tripCost.toString()}",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
