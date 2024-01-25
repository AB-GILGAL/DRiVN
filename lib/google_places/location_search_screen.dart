import 'package:drivn_customer/controllers/rental_controller.dart';
import 'package:drivn_customer/google_places/autocomplate_prediction.dart';
import 'package:drivn_customer/google_places/location_list_tile.dart';
import 'package:drivn_customer/google_places/network_utility.dart';
import 'package:drivn_customer/google_places/place_auto_complate_response.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'constants.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final RentController rentController = Get.put(RentController());

  List<AutocompletePrediction> placePredictions = [];
  Future<void> placeAutocomplete(String query) async {
    final uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": apiKey, // Replace with your API key
      },
    );
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPlace(),
    );
  }

  Widget myPlace() {
    return ListView(
      children: [
        Form(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onFieldSubmitted: (value) async {
                if (value.isNotEmpty) {
                  setState(() {
                    isSearching = true;
                  });
                } else {
                  setState(() {
                    isSearching = false;
                  });
                }
                rentController.rentLocation.value = value;
                await placeAutocomplete(value);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isSearching = true;
                  });
                } else {
                  setState(() {
                    isSearching = false;
                  });
                }
                placeAutocomplete(value);
              },
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Searching your pick-up ",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ImageIcon(AssetImage(CustomeImages.location)),
                ),
                hintStyle: const TextStyle(color: CustomeColors.greyColor),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: CustomeColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: CustomeColors.primaryColor),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: placePredictions.length,
            itemBuilder: (context, index) {
              return LocationListTile(
                press: () {
                  rentController.rentLocation.value =
                      placePredictions[index].description!;
                  Navigator.pop(context);
                  rentController.fetchAllVehicles();
                },
                location: placePredictions[index].description!,
              );
            },
          ),
        ),

        // ... (other widgets you want below the search bar)
      ],
    );
  }
}
