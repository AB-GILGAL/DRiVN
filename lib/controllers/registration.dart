// import 'package:drivn_customer/controllers/api_services.dart';
import 'package:drivn_customer/shared/shared.prefs.manager.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  // final ApiService apiService = ApiService();

  BuildContext? context;
  String? countryDialCode = "+233";
  TextEditingController lnameController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Define userId as a listenable RxString
  final RxString _userId = SharedPreferencesManager.instance.getString('userID', '').obs;

  // Getter method to access the value of userId
  String get userId => _userId.value;

  // Constructor to initialize userId from SharedPreferencesManager
  // RegistrationController() {
  //   _userId.value = SharedPreferencesManager.instance.getString('userID', '');
  // }
  // final RegistrationController registrationController =
  //     Get.put(RegistrationController());
  // ... other methods ...

  // Update userId value
  void setUserId(String newValue) {
    _userId.value = newValue;
  }

  Future<void> registerWithPhone() async {
    try {
      var headers = {"Content-Type": "application/json"};
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.registerPhone}");

      Map body = {
        "lastName": lnameController.text,
        "firstName": fnameController.text,
        "username": "$countryDialCode${phoneController.text}",
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text
      };

      // var response = await apiService.post(url, body);

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json["status"] == true) {
          // var msg = json["message"];

          // final SharedPreferences prefs = await _prefs;

          // await prefs.setString("message", msg);
          lnameController.clear();
          fnameController.clear();
          phoneController.clear();
          passwordController.clear();
          confirmPasswordController.clear();

          ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              backgroundColor: CustomeColors.whiteColor,
              content: Text(
                "An OTP code has been sent to your phone.",
                style: TextStyle(color: CustomeColors.blackColor),
              )));
          Navigator.pop(context!);
          // Get.toNamed(AppRouter.otp);
        } else {
          throw jsonDecode(response.body);
        }
      } else {
        if (jsonDecode(response.body)["errors"]["lastName"].isNotEmpty) {
          throw jsonDecode(response.body)["errors"]["lastName"];
        } else if (jsonDecode(response.body)["errors"]["firstName"]
            .isNotEmpty) {
          throw jsonDecode(response.body)["errors"]["firstName"];
        } else if (jsonDecode(response.body)["errors"]["username"].isNotEmpty) {
          throw jsonDecode(response.body)["errors"]["username"];
        } else if (jsonDecode(response.body)["errors"]["password"].isNotEmpty) {
          throw jsonDecode(response.body)["errors"]["password"];
        } else if (jsonDecode(response.body)["errors"]["confirmPassword"]
            .isNotEmpty) {
          throw jsonDecode(response.body)["errors"]["confirmPassword"];
        } else {
          throw jsonDecode(response.body) ??
              "Can not create account. StatusCode ${response.statusCode}";
        }
      }
    } catch (e) {
      print(e.toString());
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

  Future verifyOTP({String? otp}) async {
    // final ApiService apiService = ApiService();

    final prefss = SharedPreferencesManager.instance;

    try {
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.verifyOTP}$otp");

      http.Response response = await http.post(url);

      // var response = await apiService.post(url, "");

      if (response.statusCode == 200) {
        var jsonId = jsonDecode(response.body)["data"]["id"];

        if (jsonId != null) {
          await prefss.setString("userID", '$jsonId');

          // Update the userId property of RegistrationController
          var userID = prefss.getString("userID", '');
          setUserId(userID.toString());
          Get.toNamed(AppRouter.getVerified);
          // showDialog(
          //     context: context!,
          //     builder: (context) {
          //       return const AlertDialog(
          //         icon: Icon(
          //           Icons.check_circle_outline_rounded,
          //           color: Colors.green,
          //         ),
          //         title: Text("Congratulations!"),
          //         content: Text('Account created successfully'),
          //       );
          //     });
        }

        // });
      } else {
        throw "ID received from the server is not a valid string";
      }
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
}
