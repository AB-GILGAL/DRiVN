import 'package:drivn_customer/controllers/feature_controller.dart';
import 'package:drivn_customer/controllers/rental_controller.dart';
import 'package:drivn_customer/controllers/type_controller.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';

class CarBrandFilter extends StatefulWidget {
  const CarBrandFilter({super.key});

  @override
  State<CarBrandFilter> createState() => _CarBrandFilterState();
}

class _CarBrandFilterState extends State<CarBrandFilter> {
  int? isSelected;
  int? isSelected1;
  double _lv = 150.0;
  double _uv = 350.0;
  String? searhType1;
  String? searchFeature;

  final TypeController typeController =
      Get.put(TypeController(), permanent: true);
  final FeatureController featureController =
      Get.put(FeatureController(), permanent: true);
  final RentController rentController = Get.put(RentController());

  _rangeSlider() {
    return FlutterSlider(
      handlerHeight: 25,
      tooltip: FlutterSliderTooltip(
          leftPrefix: const Text(
            "\$",
            style: TextStyle(color: CustomeColors.whiteColor),
          ),
          rightPrefix: const Text(
            "\$",
            style: TextStyle(color: CustomeColors.whiteColor),
          ),
          textStyle: const TextStyle(color: CustomeColors.whiteColor),
          boxStyle: FlutterSliderTooltipBox(
              decoration: BoxDecoration(
                  color: CustomeColors.primaryColor,
                  borderRadius: BorderRadius.circular(5)))),
      trackBar: FlutterSliderTrackBar(
          activeTrackBarHeight: 4,
          inactiveTrackBarHeight: 3.5,
          activeTrackBar: BoxDecoration(
            color: CustomeColors.redColor,
          ),
          inactiveTrackBar: const BoxDecoration(
            color: CustomeColors.greyColor,
          )),
      values: [_lv, _uv],
      rangeSlider: true,
      max: 500,
      min: 50,
      onDragging: (handlerIndex, lowerValue, upperValue) {
        setState(() {
          _lv = lowerValue;
          _uv = upperValue;
          rentController.fromPrice1.value = _lv.toString();
          rentController.toPrice1.value = _uv.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height * 1,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Center(
            child: Text(
              "Filter",
              style: TextStyle(
                  fontSize: AppDimentions.mediumFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Price Range",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _rangeSlider(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Types",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                shrinkWrap: true,
                itemCount: typeController.typeList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final type = typeController.typeList[index];
                  final name = type.name;
                  return FilterCategoriesCompnent(
                    title: name,
                    index: index,
                    isSelectedIndex: isSelected,
                    onTap: () {
                      setState(() {
                        isSelected = index;
                        searhType1 = name;
                        rentController.selectedType.value = name;
                      });
                    },
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.04,
          ),
          Text(
            "Vehicle Features",
            style: TextStyle(
                fontSize: AppDimentions.mediumFontSize,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: Obx(() {
              return featureController.featureList.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      shrinkWrap: true,
                      itemCount: featureController.featureList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final feature = featureController.featureList[index];
                        final name = feature.name;
                        return FilterCategoriesCompnent(
                          title: name,
                          index: index,
                          isSelectedIndex: isSelected1,
                          onTap: () {
                            setState(() {
                              isSelected1 = index;
                              searchFeature = name;
                              rentController.selectedFeature.value = name;
                            });
                          },
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.06,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  rentController.selectedBrand.value = "";
                  rentController.selectedType.value = "";
                  rentController.selectedFeature.value = "";
                  rentController.fromPrice1.value = "";
                  rentController.toPrice1.value = "";
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        MaterialStateProperty.all(CustomeColors.bgdColor),
                    side: MaterialStateProperty.all(
                        BorderSide(color: CustomeColors.redColor))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  child: Text(
                    "Clear All",
                    style: TextStyle(color: CustomeColors.blackColor),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  rentController.fetchAllVehicles().then((value) {
                    Get.toNamed(AppRouter.index);
                  });
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor:
                        MaterialStateProperty.all(CustomeColors.primaryColor),
                    side: MaterialStateProperty.all(BorderSide(
                        color: CustomeColors.primaryColor, width: 0.2))),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                  child: Text("Apply"),
                ),
              )
            ],
          ),
        ]));
  }
}
