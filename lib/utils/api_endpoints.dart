const String placesApiKey = "AIzaSyAGyaz59rJSjFJLj01wa2l4SeuLzXKfM78";
const placesBaseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";


class ApiEndPoints {
  static const String baseUrl = "https://devapi.drivnapp.net/api";
  static AuthEndPoints authEndPoints = AuthEndPoints();
  static Uploads uploads = Uploads();
  static VehicleEndPoints vehicleEndPoints = VehicleEndPoints();
  static BookingEndPoint bookingEndPoint = BookingEndPoint();
  static DriverEndPoint driverEndPoint = DriverEndPoint();
  static ProfileEndPoint profileEndPoint = ProfileEndPoint();
}

class AuthEndPoints {
  final String registerPhone = "/customers";
  final String loginPhone = "/auth/login";
  final String session = "/auth/session";
  final String verifyOTP = "/customers/verify/";
}

class Uploads {
  final String proofOfId = "/customers/proof-identity/";
  final String driverLicense = "/customers/drivers-document/";
}

class VehicleEndPoints {
  final String brand = "/vehicle/brands";
  final String type = "/vehicle/types";
  final String feature = "/vehicle/features";
  final String rentalVehicle = "/vehicles/category/rental";
}

class BookingEndPoint{
  final String booking = "/bookings";
  final String pastBookings = "/bookings/customer/";
  final String payment = "/payment/webhook";
}

class DriverEndPoint{
  final String driver = "/drivers";
}

class ProfileEndPoint{
  final String profile = "/auth/user/update-avatar"; 
}