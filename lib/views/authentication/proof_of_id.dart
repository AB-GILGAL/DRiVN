import 'package:drivn_customer/utils/export.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get.dart';

class ProofOfIdView extends StatefulWidget {
  const ProofOfIdView({super.key});

  @override
  State<ProofOfIdView> createState() => _ProofOfIdViewState();
}

class _ProofOfIdViewState extends State<ProofOfIdView> {
  List<File?> files = [];

  Future uploadId() async {
    final SharedPreferences prefss = await SharedPreferences.getInstance();
    try {
      dynamic id = prefss.getInt("data")!;
      var url = "${ApiEndPoints.baseUrl}${ApiEndPoints.uploads.proofOfId}$id";
      var dio = Dio();
      FormData data = FormData.fromMap({
        "idCard": [
          MultipartFile.fromFileSync(files[0]!.path,
              filename: files[0]!.path.split("/").last),
          MultipartFile.fromFileSync(files[1]!.path,
              filename: files[1]!.path.split("/").last)
        ]
      });
      Response response = await dio.post(url, data: data,
          onSendProgress: (int sent, int total) {
        print("$sent $total"); 
        ScaffoldMessenger.of(context)
                              .showSnackBar( SnackBar(
                                duration: const Duration(seconds: 30),
                            content:  Padding(
              padding: const EdgeInsets.all(15.0),
              child:  LinearPercentIndicator(
                width: 150.0,
                animation: true,
                animationDuration: 1000,
                lineHeight: 20.0,
                leading: const Text("left content"),
                trailing:  const Text("right content"),
                percent: sent/total*100,
                center:  Text("${sent/total*100}%"),
                progressColor: Colors.red,
              ),
            ),
                          ));

      });

      print(response);
    } catch (e) {
      print(e);
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
              "Proof of identity.",
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
              "We need to see your full name clearly printed on the identification card.",
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
                          type: FileType.any,
                        );

                        if (result != null) {
                          List<File?> file =
                              result.paths.map((path) => File(path!)).toList();

                          
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
                          const Duration(seconds: 4),
                          () {
                            Navigator.pop(context);
                            Get.toNamed(AppRouter.proofId);
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
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CommonButton(
                bgd: CustomeColors.blackColor,
                title: "Submit",
                onPressed: () {
                  uploadId();
                 
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
