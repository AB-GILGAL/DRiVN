// import 'package:drivn_customer/controllers/api_services.dart';
import 'dart:developer';

import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/shared/shared.prefs.manager.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final customClient = getIt<HttpClientWithInterceptor>();

class LoginController extends GetxController {
  String? countryDialCode = "+233";
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<void> loginWithPhone(BuildContext context, {Map? body}) async {
    try {
      var headers = {"content-type": "application/json"};
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.loginPhone}");

      Map mapBody = body ??= {
        "username": "$countryDialCode${phoneController.text}",
        "password": passwordController.text,
      };

      // var response = await apiService.post(
      //   url,
      //  body,
      // );

      http.Response response =
          await http.post(url, body: jsonEncode(mapBody), headers: headers);
      // print(mapBody);
      if (response.statusCode != 201) {
        print(response.reasonPhrase);
      }

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var accessToken = json["accessToken"];
        var refreshToken = json["refreshToken"];

        const FlutterSecureStorage storage = FlutterSecureStorage();
        // await storage.write(key: "accessToken", value:accessToken);
        await storage.write(key: "refreshToken", value: refreshToken);

        phoneController.clear();
        passwordController.clear();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
              (route) => false);
        }
        await fetchSession();
      }
    } catch (e) {
      print(e.toString());
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Error"),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }

//this method is use at the otp view where the user is logged in silently after verifying their otp code.
  Future<void> loginWithPhoneNoRoute({Map? body}) async {
    try {
      var headers = {"content-type": "application/json"};
      var url = Uri.parse(
          "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.loginPhone}");

      Map mapBody = body ??= {
        "username": "$countryDialCode${phoneController.text}",
        "password": passwordController.text,
      };

      // var response = await apiService.post(
      //   url,
      //  body,
      // );

      http.Response response =
          await http.post(url, body: jsonEncode(mapBody), headers: headers);
      // print(mapBody);
      if (response.statusCode != 201) {
        print(response.reasonPhrase);
      }

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var accessToken = json["accessToken"];
        var refreshToken = json["refreshToken"];

        const FlutterSecureStorage storage = FlutterSecureStorage();
        // await storage.write(key: "accessToken", value:accessToken);
        await storage.write(key: "refreshToken", value: refreshToken);

        phoneController.clear();
        passwordController.clear();

        await fetchSession();
      }
    } catch (e) {
      print(e.toString());
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Error"),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }

  Future logOut() async {
    await storage.deleteAll().then(
          (value) => Get.toNamed(AppRouter.login),
        );
    await SharedPreferencesManager.instance.clearStorage();
  }
}

Future fetchSession() async {
  final prefss = SharedPreferencesManager.instance;
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  try {
    var url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.session}';
    final response = await customClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('failed to get session');
    }
    if (response.statusCode == 200) {
      final jsonID = jsonDecode(response.body)['data']['id'];
      if (jsonID != null) {
        print('user: $jsonID');

        var jsonId = jsonDecode(response.body)["data"]["id"];

        if (jsonId != null) {
          await prefss.setString("userID", '$jsonId');

          // Update the userId property of RegistrationController
          var userID = prefss.getString("userID", '');
          registrationController.setUserId(userID.toString());
        }
      }
    }
  } catch (e) {
    rethrow;
  }
}
