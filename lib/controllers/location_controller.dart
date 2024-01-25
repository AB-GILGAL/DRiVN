// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class GlobalController extends GetxController {
//   final RxBool _isLoading = true.obs;
//   final RxDouble _lat = 0.0.obs;
//   final RxDouble _lng = 0.0.obs;

//   RxBool checkLoading() => _isLoading;
//   RxDouble getLat() => _lat;
//   RxDouble getLng() => _lng;


//   @override
//   void onInit() {
//     if (_isLoading.isTrue) {
//       getLocation();
//     }
//     super.onInit();
//   }

//   getLocation() async {
//     bool isServiceEnabled;
//     LocationPermission locationPermission;


//     isServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isServiceEnabled) {
//       return Future.error("Location not enabled");
//     }

//     locationPermission = await Geolocator.checkPermission();
//     if (locationPermission == LocationPermission.deniedForever) {
//       return Future.error(
//           "Location permission is denied forever, please enable from setting");
//     } else if (locationPermission == LocationPermission.denied) {
//       locationPermission = await Geolocator.requestPermission();
//       if (locationPermission == LocationPermission.denied) {
//         return Future.error("Location permission is denied");
//       }
//     }
//     return await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((value) {
//       _lat.value = value.latitude;
//       _lng.value = value.longitude;
//       print(_lat.value);
//         _isLoading.value = false;
      

//     });
//   }
// }
