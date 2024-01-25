import 'package:drivn_customer/controllers/booked_vehicle_controller.dart';
import 'package:drivn_customer/utils/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UploadLicenceView extends StatefulWidget {
  const UploadLicenceView({super.key});

  @override
  State<UploadLicenceView> createState() => _UploadLicenceViewState();
}

class _UploadLicenceViewState extends State<UploadLicenceView> {
  List<File> files = [];
  double progressValue = 0; // Add a variable to track progress
  bool uploading = false; // Add a variable to track upload state
  final RegistrationController registrationController = Get.put(RegistrationController());




  // Future uploadLicense() async {
  //   print("Yellow Yellow");
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     uploading = true; // Set uploading state to true
  //   });

  //   try {
  //     String id = registrationController.userId.value;
  //     print("Yoyoyoyo $id");
  //     var url =
  //         "${ApiEndPoints.baseUrl}${ApiEndPoints.uploads.driverLicense}$id";
  //     // var dio = Dio();
  //     final request = http.MultipartRequest('POST', Uri.parse(url));
  //     // FormData data = FormData.fromMap({
  //     //   "documents": [
  //     //     MultipartFile.fromFileSync(files[0]!.path,
  //     //         filename: files[0]!.path.split("/").last),
  //     //     MultipartFile.fromFileSync(files[1]!.path,
  //     //         filename: files[1]!.path.split("/").last)
  //     //   ]
  //     // });
  //     for (var file in files) {
  //       request.files
  //           .add(await http.MultipartFile.fromPath('documents', file!.path));
  //     }
  //     final response = await customClient.sendMultipartRequest(request: request);
  //     // Response response = await dio.post(url, data: data,
  //     //     onSendProgress: (int sent, int total) {
  //     //   print("$sent / $total");
  //     //   setState(() {
  //     //     progressValue = sent / total; // Update progress value
  //     //   });
  //     // });

  //     if(response.statusCode != 201){
  //       print(response.statusCode);
  //     } else {
  //       print("Yaaaaaah...${response.body}");
  //     }


      
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     setState(() {
  //       uploading = false; // Set uploading state back to false
  //     });
  //   }
  // }

//   import 'dart:io';
// import 'package:http/http.dart' as http;

Future<void> uploadLicense(List<File> files) async {
  final RegistrationController registrationController = Get.put(RegistrationController());

  try {
    String id = registrationController.userId;
    var url = "${ApiEndPoints.baseUrl}${ApiEndPoints.uploads.driverLicense}$id";

    var request = http.MultipartRequest('POST', Uri.parse(url));

    for (var file in files) {
      request.files.add(await http.MultipartFile.fromPath('documents', file.path));
    }

    final response = await customClient.sendMultipartRequest(request: request);

    if (response.statusCode == 201||response.statusCode == 200) {
      // Upload successful
      print("Upload successful");
    } else {
      // Upload failed
      print("Upload failed with status code: ${response.statusCode}");
    }
  } catch (e) {
    // Handle any errors
    print("Error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.primaryColor,
      appBar: AppBar(
        backgroundColor: CustomeColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Driver's document.",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: AppDimentions.largeFontSize,
                  fontWeight: FontWeight.bold,
                  color: CustomeColors.whiteColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Upload your official driver's license.",
              style: TextStyle(
                  fontSize: AppDimentions.smallFontSize,
                  fontWeight: FontWeight.w500,
                  color: CustomeColors.greyColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            SizedBox(
              height: 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(CustomeColors.blackColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          // type: FileType.any,
                        );

                        if (result != null) {
                          List<File> file =
                              result.paths.map((path) => File(path!)).toList();

                          // print(files);
                          setState(() {
                            files = file;
                          });
                        } else {
                          // User canceled the picker and didn't select atleast 1 file from device

                          // You can show snackbar or fluttertoast here like this to show warning to user
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Please select atleast 1 file'),
                          ));
                        }

                        loadingBar(context);
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            Navigator.pop(context);
                            Get.toNamed(AppRouter.uploadlicense);
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.upload_file),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Text("Add a file",
                                style: TextStyle(
                                    fontSize: AppDimentions.smallFontSize,
                                    fontWeight: FontWeight.w500,
                                    color: CustomeColors.whiteColor))
                          ],
                        ),
                      )),
                  Expanded(
                    child: Material(
                      color: CustomeColors.whiteColor,
                      child: ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String fileName =
                              files[index]!.path.split("/").last;

                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: RichText(
                              text: TextSpan(
                                text: "File ${index + 1}:  ",
                                style: const TextStyle(
                                    height: 1.4,
                                    color: CustomeColors.blackColor,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: fileName,
                                      style: TextStyle(
                                          color: CustomeColors.redColor,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              height: 10, // Add some space for the progress indicator
              child: LinearProgressIndicator(
                value: progressValue, // Set the progress value
                backgroundColor: Colors.grey[300],
                valueColor:
                    const AlwaysStoppedAnimation<Color>(CustomeColors.blackColor),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CommonButton(
                bgd: CustomeColors.blackColor,
                title: "Submit",
                onPressed: () async {
                  // Show the dialog
                   print("Yellow Yellow2");
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (uploading)
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: LinearProgressIndicator(
                                  value:
                                      progressValue, // Set the progress value
                                  backgroundColor: Colors.grey[300],
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      CustomeColors.blackColor),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                uploading ? 'Uploading...' : 'Upload Complete!',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );

                  // Upload the license
                  await uploadLicense(files);

                  // Close the dialog when upload is complete
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.of(context).pop();
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
