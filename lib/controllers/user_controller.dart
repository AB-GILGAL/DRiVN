import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/user_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

final customClient = getIt<HttpClientWithInterceptor>();

class UserController extends GetxController {
  RxBool isLoading = true.obs;
   

  @override
  void onInit() {
    UserApi().fetchUser();

    super.onInit();
  }
}

class UserApi {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
  Future<UserModel> fetchUser() async {
    print('here');

    final userID = registrationController.userId;
    print('myID: $userID');

    try {
      var response = await customClient.get(
          '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.registerPhone}/$userID');
      if (response.statusCode == 200) {
        print(response.body);
        return userModelFromJson(response.body);
      } else {
        // Handle HTTP error status codes
        print('HTTP Error: Status code ${response.statusCode}');
        throw Exception('Fetch failed');
      }
    } catch (error) {
      // Handle specific exceptions related to HTTP requests
      print('Error in fetchind user: $error');
      rethrow;
    }
  }
}

// }
