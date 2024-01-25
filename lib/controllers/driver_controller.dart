import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/driver_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DriversController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<DriverModelData> driverList = <DriverModelData>[].obs;
  RxBool approved = true.obs;
  RxBool online = true.obs;
  RxBool booked = false.obs;
  RxBool assigned = false.obs;

  @override
  void onInit() {
    fetchAllDrivers();
    super.onInit();
  }

  Future<List<DriverModelData>> fetchAllDrivers() async {
    try {
      isLoading(true);
      var drivers = await ApiService.getDriverData(
          approved: approved.toString(),
          online: online.toString(),
          booked: booked.toString(),
          assigned: assigned.toString());
      driverList.value = drivers;
      return drivers;
    } finally {
      isLoading(false);
    }
  }
}

final customClient = getIt<HttpClientWithInterceptor>();

class ApiService {
  static Future<List<DriverModelData>> getDriverData({
    required String approved,
    required String online,
    required String booked,
    required String assigned,
  }) async {
    final queryParameters = {
      'approved': approved,
      'online': online,
      'booked': booked,
      'assigned': assigned,
    };

    final uri =
        Uri.https("devapi.drivnapp.net", "api/drivers", queryParameters);
    var response = await customClient.getWithHttp(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });

    print(response.body);
    if (response.statusCode == 200) {
      return driversModelFromJson(response.body).data?.data ?? [];
    } else {
      return [];
    }
  }
}
