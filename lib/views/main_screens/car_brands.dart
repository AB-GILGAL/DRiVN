import 'package:drivn_customer/controllers/brand_controller.dart';
import 'package:drivn_customer/controllers/rental_controller.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class CarBrandSearch extends StatefulWidget {
  const CarBrandSearch({super.key});

  @override
  State<CarBrandSearch> createState() => _CarBrandSearchState();
}

class _CarBrandSearchState extends State<CarBrandSearch> {
  int isSelected = 0;
  String? searchBrand;
  final BrandController brandController =
      Get.put(BrandController(), permanent: true);
  final RentController rentController = Get.put(RentController());

  TextEditingController searchController = TextEditingController();

  List<BrandDataModel> _foundRide = [];
  @override
  initState() {
    brandController.fetchAllBrands();

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<BrandDataModel> results = [];
    if (enteredKeyword.isEmpty) {
      results = brandController.brandList;
    } else {
      results = brandController.brandList
          .where((crs) =>
              crs.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundRide = results;
    });
  }

  Widget _buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: CustomeColors.whiteColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            controller: scrollController,
            children: const [
              CarBrandFilter()
              ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.bgdColor,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: CustomeColors.blackColor,
          ),
        ),
        backgroundColor: CustomeColors.bgdColor,
        title: const Text(
          "Search",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
              child: Row(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        _runFilter(value);
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          focusColor: CustomeColors.greyColor,
                          hintText: "Search",
                          filled: true,
                          fillColor: CustomeColors.whiteColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.02,
                  ),
                  InkWell(
                      onTap: () {
                        showFlexibleBottomSheet(
                          bottomSheetColor: Colors.transparent,
                          minHeight: 0,
                          initHeight: 0.7,
                          maxHeight: 0.9,
                          context: context,
                          builder: _buildBottomSheet,
                          anchors: [0, 0.7, 0.9],
                          isSafeArea: false,
                        );
                      },
                      child: ImageIcon(AssetImage(CustomeImages.filter)))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            Text(
              "All Brands",
              style: TextStyle(
                  fontSize: AppDimentions.largeFontSize,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            Expanded(child: Obx(() {
              return brandController.brandList.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                           SizedBox(height: MediaQuery.sizeOf(context).height * 0.015,),
                      shrinkWrap: true,
                      itemCount: _foundRide.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final brand = _foundRide[index];
                        final bName = brand.name;
                        final image = brand.logo;
                        final available = brand.availableVehicles;
                        return ListTile(
                          onTap: () {
                            setState(() {
                              isSelected = index;
                              searchBrand = bName;
                              rentController.selectedBrand.value = bName;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          tileColor: CustomeColors.whiteColor,
                          leading: Container(
                            height: MediaQuery.sizeOf(context).height * 0.15,
                            width: MediaQuery.sizeOf(context).width * 0.15,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(image.toString()),
                                    fit: BoxFit.cover)),
                          ),
                          title: Text(
                            bName.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("$available cars available"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            })),
          ],
        ),
      ),
    );
  }
}
