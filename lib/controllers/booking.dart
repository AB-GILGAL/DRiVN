import 'package:drivn_customer/controllers/booked_vehicle_controller.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:path/path.dart';

class BookingController extends GetxController {
  BuildContext? context;

  Future<void> bookVehicle({
    BuildContext? context,
    String? customer,
    String? customerLocation,
    String? reference,
    File? customerLocationAudio,
    int? driver,
    int? driverAmount,
    int? driver2Id,
    int? driver2Amount,
    String? pickupDate,
    String? pickupTime,
    String? returnDate,
    String? returnTime,
    double? refundAmount,
    int? vehicle,
    int? vehicleAmount,
  }) async {
    try {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              ApiEndPoints.baseUrl + ApiEndPoints.bookingEndPoint.booking));
      var audio = await http.MultipartFile.fromPath(
          "customerLocationAudio", customerLocationAudio!.path);

      //add multipart to request
      request.files.add(audio);
      //add text fields
      request.fields["customer"] = customer.toString();
      request.fields["customerLocation"] = customerLocation ?? "";
      request.fields["reference"] = reference ?? "";
      request.fields["driver"] = driver?.toString() ?? "";
      request.fields["driverAmount"] = driverAmount?.toString() ?? "";
      request.fields["pickupDate"] = pickupDate ?? "";
      request.fields["pickupTime"] = pickupTime ?? "";
      request.fields["returnDate"] = returnDate ?? "";
      request.fields["returnTime"] = returnTime ?? "";
      request.fields["refundAmount"] = refundAmount?.toString() ?? "";
      request.fields["vehicle"] = vehicle.toString();
      request.fields["vehicleAmount"] = vehicleAmount?.toString() ?? "";

      var response = await customClient.sendMultipartRequest(request: request);

//    Get the response from the server
    //  var responseString = jsonDecode(response.body);
   
      if (response.statusCode == 201) {
        // ... handle success ...

        payment(reference);

        if (context!.mounted) {
          Navigator.pop(context);
          _showDialog(context).show();
          // showSuccessSnackBar(message: message, context: context);
        }
      }
    } catch (e) {
      // Handle exceptions here

      if (context != null && context.mounted) {
        // Show an error dialog or snackbar
        // Example: showErrorDialog(context, 'An error occurred');
        Get.back();
        showDialog(
            context: Get.context!,
            builder: (context) {
              return AlertDialog(
                icon: Icon(
                  Icons.cancel_outlined,
                  color: CustomeColors.redColor,
                ),
                title: const Text("Oops!"),
                contentPadding: const EdgeInsets.all(20),
                content: Text(e.toString()),
              );
            });
      }
    }
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
          onPressed: () {
            Get.toNamed(AppRouter.index);
          },
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
    // btnOkOnPress: () => Get.toNamed(AppRouter.index),
  );
}

Future<void> payment(dynamic reference) async {
  BuildContext? context;

  try {
    var headers = {"Content-Type": "application/json"};
    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.bookingEndPoint.payment);

    Map<String, dynamic> body = {
      "trans_status": "000/01",
      "trans_ref": reference,
      "trans_id": "732897589379",
      "message": "SUCCESSFUL"
    };

    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["status"] == true) {
        ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
            duration: Duration(seconds: 4),
            backgroundColor: CustomeColors.whiteColor,
            content: Text(
              "Payment is successful.",
              style: TextStyle(color: CustomeColors.blackColor),
            )));
        Navigator.pop(context);
      } else {
        throw jsonDecode(response.body);
      }
    } else {}
  } catch (e) {
    Get.back();
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.cancel_outlined,
            color: CustomeColors.redColor,
          ),
          title: const Text("Oops!"),
          contentPadding: const EdgeInsets.all(20),
          content: Text(e.toString()),
        );
      },
    );
  }
}
