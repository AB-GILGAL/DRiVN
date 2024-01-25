import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/feature_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final customClient = getIt<HttpClientWithInterceptor>();

class FeatureController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<FeatureDataModel> featureList = <FeatureDataModel>[].obs;

  @override
  void onInit() {
    fetchAllFeatures();
    super.onInit();
  }

  void fetchAllFeatures() async {
    try {
      isLoading(true);
      var features = await Api.fetchFeatures();
      featureList.value = features.data.data;
      print(featureList[0].name);
    } catch (error) {
      // Handle specific exceptions
      if (error is Exception) {
        print('Exception occurred: $error');
      } else {
        print('Error occurred: $error');
      }
    } finally {
      isLoading(false);
    }
  }
}

class Api {
  static Future<FeatureModel> fetchFeatures() async {
    try {
      var response = await customClient.get
          ("${ApiEndPoints.baseUrl}${ApiEndPoints.vehicleEndPoints.feature}");
      if (response.statusCode == 200) {
        return featureModelFromJson(response.body);
      } else {
        throw Exception('Failed to load features: Status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error in fetchFeatures: $error');
      rethrow;
    }
  }
}

// class FeatureController extends GetxController {
//   RxBool isLoading = true.obs;
//   RxList<FeatureDataModel> featureList = <FeatureDataModel>[].obs;
  

//   @override
//   void onInit() {
//     fetchAllFeatures();
//     super.onInit();
//   }

//   void fetchAllFeatures() async {
//     try {
//       isLoading(true);
//       var features = await Api.fetchFeatures();
//       featureList.value = features.data.data;
//       print(featureList[0].name);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// class Api {
//   static Future<FeatureModel> fetchFeatures() async {
//     var response = await http.get(
//         Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.vehicleEndPoints.feature));
//     if (response.statusCode == 200) {
//       return featureModelFromJson(response.body);
//     } else {
//       return null!;
//     }
//   }
// }