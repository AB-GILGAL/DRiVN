import 'package:drivn_customer/controllers/booking.dart';
import 'package:drivn_customer/controllers/driver_controller.dart';
import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class DriverScreen extends StatefulWidget {
  final Vehicle? vehicleList;
  final int? total;
  const DriverScreen({Key? key, this.total, this.vehicleList}) : super(key: key);

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  int isSelected = 0;
  String? image;
  int? driverId;
  int? driverRate;
  bool? withDriver;
  final DriversController driversController = Get.put(DriversController());
  final BookingController bookingController = Get.put(BookingController());

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
          "Driver Details",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(() {
            return driversController.driverList.isNotEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.88,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        itemCount: driversController.driverList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final driver = driversController.driverList[index];
                          final fName = driver.firstName;
                          final lName = driver.lastName;
                          final rate = driver.document.rate;
                          final id = driver.id;
                          
                          return DriverTile(
                            index: index,
                            isSelectedIndex: isSelected,
                            onTap: () {
                              setState(() {
                                isSelected = index;
                                driverId = id;
                                driverRate = rate;
                                // Navigator.of(context).pop(DateAndTime(driverId: driverId, driverRate: driverRate,));

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return DateAndTime(driverId: id, driverRate: rate, withDriver: true, total: widget.total, vehicleList: widget.vehicleList,
                                  );
                                },
                                ));
                                
                                print("$driverId yah $driverRate");
                              });
                            },
                            fName: fName,
                            lName: lName,
                            amt: rate.toString(),
                          );
                        }),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(
                      child: Text("No driver available."),
                    ),
                  );
          })
        ],
      ),
    );
  }
}

class DriverTile extends StatelessWidget {
  const DriverTile(
      {super.key,
      this.onTap,
      this.img,
      this.fName,
      this.lName,
      this.amt,
      this.reviews,
      this.index,
      this.isSelectedIndex});
  final void Function()? onTap;
  final int? isSelectedIndex;
  final int? index;
  final String? img;
  final String? fName;
  final String? lName;
  final String? amt;
  final String? reviews;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(CustomeImages.ab),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          "$fName $lName",
          style: TextStyle(
              fontSize: AppDimentions.smallFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: CustomeColors.yellowColor,
                size: 15,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                "4.8 Rating",
                style: TextStyle(
                  fontSize: AppDimentions.extraSmallFontSize,
                  // fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                "¢$amt ",
                style: TextStyle(
                    color: CustomeColors.blackColor,
                    fontSize: AppDimentions.smallFontSize,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "per hour",
              )
            ],
          ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.5),
        child: CommonButton(
          title: "Hire",
          bgd: CustomeColors.primaryColor,
          onPressed: onTap,
        ),
      ),
    );
  }
}
