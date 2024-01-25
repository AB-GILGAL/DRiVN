import 'package:drivn_customer/controllers/http_interceptor.dart';
import 'package:drivn_customer/shared/shared.prefs.manager.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
  GetIt getIt = GetIt.instance;
setupInterceptorLocator(){
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<HttpClientWithInterceptor>(() => HttpClientWithInterceptor
  (getIt<http.Client>()));
}