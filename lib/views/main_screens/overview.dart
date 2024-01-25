import 'package:audioplayers/audioplayers.dart';
import 'package:drivn_customer/controllers/booking.dart';
import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

class VehicleOverview extends StatefulWidget {
  final String recordFilePath;
  final String textLocation;
  final String startDate;
  final String endDate;
  final String startDate2;
  final String endDate2;
  final String startTime;
  final String endTime;
  final int driverId;
  final int driverRate;
  final Vehicle vehicleList;
  final int total;
  final int rentHours;

  const VehicleOverview(
      {Key? key,
      required this.recordFilePath,
      required this.startDate,
      required this.endDate,
      required this.startDate2,
      required this.endDate2,
      required this.startTime,
      required this.endTime,
      required this.textLocation,
      required this.driverId,
      required this.driverRate,
      required this.vehicleList,
      required this.total,
      required this.rentHours})
      : super(key: key);

  @override
  State<VehicleOverview> createState() => _VehicleOverviewState();
}

class _VehicleOverviewState extends State<VehicleOverview> {
  BookingController bookingController = Get.put(BookingController());
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  int? customer;
  String? customerLocation;
  File? customerLocationAudio;
  int? driver;
  int? driverAmount;
  String? pickupDate;
  String? pickupTime;
  String? reference;
  double? refundAmount;
  String? returnDate;
  String? returnTime;
  int? vehicle;
  int vehicleAmount = 0;
  int totalPrice = 0;

  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  // Add a variable to track the audio player state
  var audioPlayerState = AudioPlayer().stop();

  // Add a variable to track the duration of the audio
  Duration totalDuration = const Duration();

  // Add a variable to track the current position of the audio
  Duration currentPosition = const Duration();

  @override
  void initState() {
    audioPlayer = AudioPlayer();

    vehicleAmount = widget.vehicleList.rental?.price != null
        ? widget.vehicleList.rental!.price * widget.rentHours
        : 0 * widget.rentHours;
    driverAmount = widget.vehicleList.rental?.driver?.rate != null
        ? widget.vehicleList.rental!.driver!.rate * widget.rentHours
        : widget.driverRate * widget.rentHours;
    totalPrice = vehicleAmount + driverAmount!;

    reference = randomAlphaNumeric(12);
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    try {
      Source urlSource = UrlSource(widget.recordFilePath);
      audioPlayer.onPositionChanged.listen((Duration position) {
        setState(() {
          currentPosition = position;
        });
      });
      audioPlayer.onDurationChanged.listen((Duration duration) {
        setState(() {
          totalDuration = duration;
        });
      });
      await audioPlayer.play(urlSource);
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Record error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            "Overview",
            style: TextStyle(
              color: CustomeColors.blackColor,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.vehicleList.images[0].image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.05,
                      ),
                      Text(
                        widget.vehicleList.type,
                        style: TextStyle(
                            fontSize: AppDimentions.mediumFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                  Text(
                    "Pick-up time",
                    style: TextStyle(
                        fontSize: AppDimentions.mediumFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(widget.startDate2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(widget.startTime),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                  Text(
                    "Return time",
                    style: TextStyle(
                        fontSize: AppDimentions.mediumFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(widget.endDate2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(widget.endTime),
                            ),
                          ),
                        ),
                      ),
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
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            width: 0.2, color: CustomeColors.redColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
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
                                widget.textLocation,
                                style: TextStyle(
                                    fontSize: AppDimentions.mediumFontSize,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          // const Text("0.5km")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.67,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        child: Material(
                          color: CustomeColors.whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isPlaying
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_outline,
                                    color: CustomeColors.redColor,
                                  ),
                                  onPressed: () {
                                    playAudio();
                                    if (isPlaying) {
                                      audioPlayer.pause();
                                      setState(() {
                                        isPlaying = false;
                                      });
                                    } else {
                                      audioPlayer.resume();
                                      setState(() {
                                        isPlaying = true;
                                      });
                                    }
                                  },
                                ),
                                isPlaying
                                    ? Expanded(
                                        child: SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            trackHeight:
                                                0.3, // Adjust the track height here
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius:
                                                    6), // Adjust the thumb size here
                                          ),
                                          child: Slider(
                                            activeColor: CustomeColors.redColor,
                                            thumbColor:
                                                CustomeColors.yellowColor,
                                            value: currentPosition
                                                .inMicroseconds
                                                .toDouble(),
                                            max: totalDuration.inMicroseconds
                                                .toDouble(),
                                            onChanged: (value) {
                                              audioPlayer.seek(Duration(
                                                  microseconds: value.toInt()));
                                            },
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        "Play pick up location",
                                        style: TextStyle(
                                            color: CustomeColors.whiteColor),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
                      Text(
                          "(${currentPosition.inMilliseconds}/${totalDuration.inMilliseconds})")
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
                        side: BorderSide(
                            width: 0.2, color: CustomeColors.redColor)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
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
                                    height: MediaQuery.sizeOf(context).height *
                                        0.015,
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
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                CustomeColors.primaryColor)),
                        onPressed: () {
                          loadingBar(context);
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              // final SharedPreferences prefss = await SharedPreferences.getInstance();

                              // dynamic id = prefss.getInt("data")!;
                              bookingController.bookVehicle(
                                customerLocationAudio: File(widget
                                    .recordFilePath), // Pass the audio file
                                context: context,
                                customer: registrationController.userId,
                                customerLocation: widget.textLocation,
                                reference: reference,
                                driver: widget.vehicleList.rental?.driver?.id !=
                                        null
                                    ? widget.vehicleList.rental!.driver!.id
                                    : widget.driverId,
                                driverAmount: driverAmount,
                                pickupDate: "${widget.startDate}Z",
                                pickupTime: "${widget.startDate}Z",
                                returnDate: "${widget.endDate}Z",
                                returnTime: "${widget.endDate}Z",
                                refundAmount: 0,
                                vehicle: widget.vehicleList.id,
                                vehicleAmount: vehicleAmount,
                              );
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
                                "  GH¢ $totalPrice  ",
                                style: TextStyle(
                                    fontSize: AppDimentions.mediumFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: CustomeColors.whiteColor),
                              )
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
