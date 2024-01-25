import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/bookings_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class BookedVehiclesController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<BookingDataModel> bookedVehicleList = <BookingDataModel>[].obs;
  RxBool completed = false.obs;
  final RegistrationController registrationController = Get.put(RegistrationController());


  @override
  void onInit() {
    fetchAllVehicles();
    super.onInit();
  }

  Future<List<BookingDataModel>> fetchAllVehicles() async {
  try {
    isLoading(true);
    var vehicles = await ApiService.getBookedVehicleData(
      completed: completed.toString(),
    );
    bookedVehicleList.value = vehicles;
    return vehicles;
  } finally {
    isLoading(false);
  }
}

}

final customClient = getIt<HttpClientWithInterceptor>();

class ApiService {
 static Future<List<BookingDataModel>> getBookedVehicleData({required String completed,})async{
   final queryParameters = {
  'completed': completed,
 

};
  final RegistrationController registrationController = Get.put(RegistrationController());


  final uri =
    Uri.https("devapi.drivnapp.net" , "api/bookings/customer/${registrationController.userId}", queryParameters);
  var response = await customClient.getWithHttp(uri, headers: {
  HttpHeaders.contentTypeHeader: 'application/json',
});

print(response.body);
if (response.statusCode == 200) {
  
      return bookingModelFromJson(response.body).data?.data??[];

      
    } else {
      return [];
    }

}


}


