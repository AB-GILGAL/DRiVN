import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/bookings_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PastBookingController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<BookingDataModel> pastBookingList = <BookingDataModel>[].obs;
  RxBool completed = true.obs;


  @override
  void onInit() {
    fetchAllVehicles();
    super.onInit();
  }

  Future<List<BookingDataModel>> fetchAllVehicles() async {
  try {
    isLoading(true);
    var vehicles = await ApiService.getPastBookingData(
      completed: completed.toString(),
    );
    pastBookingList.value = vehicles;
    return vehicles;
  } finally {
    isLoading(false);
  }
}

}
final customClient = getIt<HttpClientWithInterceptor>();

class ApiService {
 static Future<List<BookingDataModel>> getPastBookingData({required String completed,})async{
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


