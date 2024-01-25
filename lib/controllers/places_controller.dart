// import 'package:drivn_customer/controllers/api_services.dart';
// import 'package:drivn_customer/shared/locator.dart';
// import 'package:drivn_customer/utils/export.dart';
// // import 'package:http/http.dart' as http;

// final customClient = getIt<HttpClientWithInterceptor>();
// class PlaceAPI{
//   static Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers})async{
//     try{
//       final response = await customClient.getWithHttp(uri, headers: headers);
//       if(response.statusCode == 200){
//         return response.body;
//       }
//     }catch(e){
//       debugPrint(e.toString());
//     }
//     return null;
//   }
// }