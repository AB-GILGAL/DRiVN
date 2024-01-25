import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/models/type_model.dart';
import 'package:drivn_customer/shared/locator.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';


class TypeController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<TypeDataModel> typeList = <TypeDataModel>[].obs;

  @override
  void onInit() {
    fetchAllTypes();
    super.onInit();
  }

  void fetchAllTypes() async {
    try {
      isLoading(true);
      var types = await Api.fetchTypes();
      typeList.value = types.data.data;
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
final customClient = getIt<HttpClientWithInterceptor>();
class Api {
  static Future<TypeModel> fetchTypes() async {
    try {
      var response = await customClient.get(
         '${ApiEndPoints.baseUrl}${ApiEndPoints.vehicleEndPoints.type}');
      if (response.statusCode == 200) {
        return typeModelFromJson(response.body);
      } else {
        throw Exception('Failed to load types: Status code ${response.statusCode}');
      }
    } catch (error) {
      // Handle specific exceptions related to HTTP requests
      print('Error in fetchTypes: $error');
      rethrow; // Rethrow the exception for further handling if needed
    }
  }
}