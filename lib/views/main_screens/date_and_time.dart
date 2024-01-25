import 'package:drivn_customer/models/rental_model.dart';
import 'package:drivn_customer/views/main_screens/drivers.dart';
import 'package:record/record.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:intl/intl.dart';

class DateAndTime extends StatefulWidget {
  final Vehicle? vehicleList;
  final int? total;
  final int? driverId;
  final int? driverRate;
  final bool? withDriver;
  const DateAndTime(
      {Key? key,
      this.driverId,
      this.driverRate,
      this.withDriver,
      this.total,
      this.vehicleList})
      : super(key: key);

  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  late Record audioRecord;
  String statusText = "Record pickup location";
  bool isRecording = false;
  String? recordFilePath = "";
  String? textLocation = "";
  String? startDate;
  String? endDate;
  String? startDate2;
  String? endDate2;
  String? startTime = "";
  String? endTime = "";
  bool? withDriver;
  int rentHours = 0;

  TextEditingController locationController = TextEditingController();

  static TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 9)),
  ];

  String toIso8601String(DateTime dateTime) {
    return dateTime.toIso8601String();
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : '';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        var startDate0 = values[0]!;
        var endDate0 =
            values.length > 1 ? values[1]! : null; // Change this to null
        var startDate1 = values[0]!.add(Duration(
            hours: selectedStartTime.hour, minutes: selectedStartTime.minute));
        var endDate1 = values.length > 1
            ? values[1]!.add(Duration(
                hours: selectedEndTime.hour, minutes: selectedEndTime.minute))
            : null; // Change this to null

        String format(DateTime dt) {
          return dt.toIso8601String().substring(0, 19);
        }

// Assuming format is a function that formats the date
        String format0(DateTime date) {
          return DateFormat('dd-MMM-yyyy').format(date);
        }

        valueText =
            '${format0(startDate0)} - ${endDate0 != null ? format0(endDate0) : ''}';
        startDate = startDate;
        setState(() {
          startDate2 = format0(startDate0);
          endDate2 = endDate0 != null ? format0(endDate0) : '';
          startDate = format(startDate1);
          endDate = endDate1 != null ? format(endDate1) : '';
          rentHours = selectedEndTime.hour - selectedStartTime.hour;
        });
      } else {
        return '';
      }
    }

    return valueText;
  }

  @override
  void initState() {
    audioRecord = Record();
    withDriver = widget.withDriver ?? false;
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    super.dispose();
  }

  void recordLocation() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isRecording = true;
      RecordMp3.instance.start(recordFilePath!, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }

  ////CHECK PERMISSION
  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

//GET Device storage location
  int i = 0;
  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = "${storageDirectory.path}/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  void stopRecording() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isRecording = false;
      setState(() {});
    }
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: CustomeColors.redColor,
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      children: [
        CalendarDatePicker2(
          config: config,
          value: _rangeDatePickerValueWithDefaultValue,
          onValueChanged: (dates) =>
              setState(() => _rangeDatePickerValueWithDefaultValue = dates),
        ),
        Text(
          _getValueText(
            config.calendarType,
            _rangeDatePickerValueWithDefaultValue,
          ),
        ),
      ],
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
            "Date & Time",
            style: TextStyle(
              color: CustomeColors.blackColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              width: 0.2, color: CustomeColors.redColor)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Book with driver",
                                  style: TextStyle(
                                      fontSize: AppDimentions.mediumFontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.015,
                                ),
                                Switch(
                                  activeColor: CustomeColors.redColor,
                                  value: withDriver!,
                                  onChanged: (value) {
                                    setState(() {
                                      withDriver = value;
                                      if (withDriver == true) {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return DriverScreen(
                                                vehicleList: widget.vehicleList,
                                                total: widget.total);
                                          },
                                        ));
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Don't have a driver? Book with the driver",
                              style: TextStyle(
                                  color: CustomeColors.greyColor,
                                  fontSize: AppDimentions.smallFontSize,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      width: 375,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: _buildDefaultRangeDatePickerWithValue(),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Pick-up time",
                              style: TextStyle(
                                  fontSize: AppDimentions.smallFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        width: 0.2,
                                        color: CustomeColors.redColor)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                      Text(
                                          "${selectedStartTime.hour}:${selectedStartTime.minute}"),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.06,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final TimeOfDay? timeOfDate =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      selectedStartTime,
                                                  initialEntryMode:
                                                      TimePickerEntryMode.dial);
                                          if (timeOfDate != null) {
                                            setState(() {
                                              selectedStartTime = timeOfDate;
                                              startTime =
                                                  "${timeOfDate.hour}: ${timeOfDate.minute}";
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomeColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Return time",
                              style: TextStyle(
                                  fontSize: AppDimentions.smallFontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.01,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(
                                        width: 0.2,
                                        color: CustomeColors.redColor)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.04,
                                      ),
                                      Text(
                                          "${selectedEndTime.hour}:${selectedEndTime.minute}"),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.06,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final TimeOfDay? timeOfDate =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: selectedEndTime,
                                                  initialEntryMode:
                                                      TimePickerEntryMode.dial);
                                          if (timeOfDate != null) {
                                            setState(() {
                                              selectedEndTime = timeOfDate;
                                              endTime =
                                                  "${timeOfDate.hour}: ${timeOfDate.minute}";
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomeColors.blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Text(
                      "My pick-up location",
                      style: TextStyle(
                          fontSize: AppDimentions.smallFontSize,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: locationController,
                        cursorColor: CustomeColors.blackColor,
                        decoration: InputDecoration(
                          fillColor: CustomeColors.whiteColor,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.2, color: CustomeColors.redColor)),
                          prefixIcon: ImageIcon(
                            AssetImage(CustomeImages.location),
                            color: CustomeColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.6,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.2, color: CustomeColors.redColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.02,
                              ),
                              Expanded(
                                  child: Text(
                                statusText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  isRecording
                                      ? stopRecording()
                                      : recordLocation();
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.mic,
                                  color: isRecording
                                      ? CustomeColors.redColor
                                      : CustomeColors.blackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Center(
                      child: CommonButton(
                        onPressed: () async {
                          if (widget.vehicleList?.rental?.driver?.id == null &&
                              widget.driverId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Container(
                                  padding: const EdgeInsets.all(15),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      color: CustomeColors.redColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Oops!',
                                        style: TextStyle(
                                            fontSize:
                                                AppDimentions.mediumFontSize),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Kindly book with a driver.',
                                        style: TextStyle(
                                            fontSize:
                                                AppDimentions.smallFontSize),
                                      ),
                                    ],
                                  )),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ));
                          } else {
                            await Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return VehicleOverview(
                                  recordFilePath: recordFilePath!,
                                  startDate: startDate!,
                                  endDate: endDate!,
                                  startDate2: startDate2!,
                                  endDate2: endDate2!,
                                  startTime: startTime!,
                                  endTime: endTime!,
                                  textLocation: locationController.text,
                                  driverId: widget.driverId ?? 0,
                                  driverRate: widget.driverRate ?? 0,
                                  vehicleList: widget.vehicleList!,
                                  total: widget.total!,
                                  rentHours: rentHours,
                                );
                              },
                            ));
                          }
                        },
                        title: "Proceed to payment",
                        bgd: CustomeColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                  ]),
            )));
  }
}
