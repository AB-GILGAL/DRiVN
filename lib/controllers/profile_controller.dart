// import 'dart:convert';

// import 'package:drivn_customer/controllers/booked_vehicle_controller.dart';
// import 'package:drivn_customer/utils/api_endpoints.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class UserController extends GetxController {
//   var userProfileImageUrl = ''.obs;

//   // Update the user's profile image
//   Future<void> updateUserProfileImage(String imagePath) async {
//     // Replace with your API endpoint
//     var apiUrl = '${ApiEndPoints.baseUrl}${ApiEndPoints.profileEndPoint}';

//     // Create a FormData object to send the image
//     var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
//     request.files.add(await http.MultipartFile.fromPath('data', imagePath));

//     try {
//       final response = await customClient.sendMultipartRequest(request: request);
//       if (response.statusCode == 200) {
//         print("Wooow successfully updated");
//         // Update the user's profile image URL in the controller
//         userProfileImageUrl.value = jsonDecode(response.body)["data"]; // Replace with the actual new image URL
//       } else {
//         // Handle error here
//         print('Failed to update profile image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//     }
//   }
// }
import 'dart:convert';

import 'package:drivn_customer/controllers/booked_vehicle_controller.dart';
import 'package:drivn_customer/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class UserController extends GetxController {
  var userProfileImageUrl = ''.obs;

  // Update the user's profile image
  Future<void> updateUserProfileImage(String imagePath) async {
    try {
      var apiUrl = '${ApiEndPoints.baseUrl}${ApiEndPoints.profileEndPoint}'; // Replace with your API endpoint
      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('avatar', imagePath));

      final response = (await customClient.sendMultipartRequest(request: request));

      if (response.statusCode == 200) {
        print("Successfully updated");
        // Update the user's profile image URL in the controller
        userProfileImageUrl.value = jsonDecode(response.body)["data"]; // Replace with the actual new image URL
      } else {
        // Handle error here
        print('Failed to update profile image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
    }
  }
}
