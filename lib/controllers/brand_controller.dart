import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


final customClient = getIt<HttpClientWithInterceptor>();

class BrandController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<BrandDataModel> brandList = <BrandDataModel>[].obs;

  @override
  void onInit() {
    fetchAllBrands();
    super.onInit();
  }

  void fetchAllBrands() async {
    try {
      isLoading(true);
      var brands = await Api.fetchBrands();
      if (brands != null) {
        brandList.value = brands.data.data;
        if (brandList.isNotEmpty) {
          print(brandList[0].name);
        }
      } else {
        // Handle the case where brands is null (e.g., API call failed)
        print('Failed to fetch brands');
      }
    } catch (error) {
      // Handle specific exceptions
      if (error is Exception) {
        // Handle exceptions that are of type Exception
        print('Exception occurred: $error');
      } else {
        // Handle other types of errors
        print('Error occurred: $error');
      }
    } finally {
      isLoading(false);
    }
  }
}

class Api {
  static Future<BrandModel?> fetchBrands() async {
    try {
      var response = await customClient.get
          ('${ApiEndPoints.baseUrl}${ ApiEndPoints.vehicleEndPoints.brand}');
      if (response.statusCode == 200) {
        return brandModelFromJson(response.body);
      } else {
        // Handle HTTP error status codes
        print('HTTP Error: Status code ${response.statusCode}');
        return null; // Indicate that the API call failed
      }
    } catch (error) {
      // Handle specific exceptions related to HTTP requests
      print('Error in fetchBrands: $error');
      return null; // Indicate that the API call failed
    }
  }
}



// class BrandController extends GetxController {
//   RxBool isLoading = true.obs;
//   RxList<BrandDataModel> brandList = <BrandDataModel>[].obs;
  

//   @override
//   void onInit() {
//     fetchAllBrands();
//     super.onInit();
//   }

//   void fetchAllBrands() async {
//     try {
//       isLoading(true);
//       var brands = await Api.fetchBrands();
//       brandList.value = brands.data.data;
//       print(brandList[0].name);
//     } finally {
//       isLoading(false);
//     }
//   }
// }

// class Api {
//   static Future<BrandModel> fetchBrands() async {
//     var response = await http.get(
//         Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.vehicleEndPoints.brand));
//     if (response.statusCode == 200) {
//       return brandModelFromJson(response.body);
//     } else {
//       return null!;
//     }
//   }
// }
