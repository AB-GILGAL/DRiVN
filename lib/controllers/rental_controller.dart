import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/controllers/type_controller.dart';
import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RentController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Vehicle> vehicleList = <Vehicle>[].obs;
  RxBool withDriver = false.obs;
  RxBool booked = false.obs;
  RxString rentLocation = 'Accra'.obs;
  final TypeController typeController = Get.put(TypeController());

  void setWithDriver(bool newValue) {
    withDriver.value = newValue;
    // fetchAllVehicles() here to refetch data with the new filter.
    fetchAllVehicles();
  }

  // Add filter parameters
  RxString selectedType = ''.obs;
  RxString selectedBrand = ''.obs;
  RxString selectedFeature = ''.obs;
  RxString fromPrice1 = ''.obs;
  RxString toPrice1 = ''.obs;

  @override
  void onInit() {
    fetchAllVehicles();
    super.onInit();
  }

  Future<List<Vehicle>> fetchAllVehicles() async {
    try {
      isLoading(true);
      var vehicles = await ApiService.getRentalData(
        location: rentLocation.value,
        driver: withDriver.value.toString(),
        booked: booked.toString(),
        type: selectedType.value,
        brand: selectedBrand.value,
        feature: selectedFeature.value,
        fromPrice: fromPrice1.value,
        toPrice: toPrice1.value,
      );
      return vehicles;
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
    return []; // Return an empty list in case of an error
  }

  // ... (existing code)
}

final customClient = getIt<HttpClientWithInterceptor>();

class ApiService {
  static Future<List<Vehicle>> getRentalData({
    required String location,
    required String driver,
    required String booked,
    String? type,
    String? brand,
    String? feature,
    String? fromPrice,
    String? toPrice,
  }) async {
    try {
      final queryParameters = {
        'location': location,
        'with-driver': driver,
        'booked': booked,
        'type': type,
        'brand': brand,
        'feature': feature,
        'fromPrice': fromPrice,
        'toPrice': toPrice,
      };
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.https("devapi.drivnapp.net",
          "api/vehicles/category/rental", queryParameters);
      var response = await customClient.getWithHttp(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      print("Rental...  ${response.body}");

      if (response.statusCode == 200) {
        return rentalVehicleModelFromJson(response.body).data?.data ?? [];
      } else {
        return [];
      }
    } catch (error) {
      // Handle specific exceptions related to HTTP requests
      print('Error in getRentalData: $error');
      return []; // Return an empty list in case of an error
    }
  }
}
