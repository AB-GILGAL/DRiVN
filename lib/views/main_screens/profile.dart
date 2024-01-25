import 'package:drivn_customer/controllers/profile_controller.dart';
import 'package:drivn_customer/controllers/user_controller.dart' as u;
import 'package:drivn_customer/utils/export.dart';

import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';

import '../../controllers/login.dart';
import '../../models/user_model.dart';

// import 'package:drivn_customer/controllers/user_controller.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
  final UserController userController =
      Get.put(UserController(), permanent: true);
}

class _ProfileViewState extends State<ProfileView> {
  final UserController userController = Get.find<UserController>();

  final loginController = Get.put(LoginController());
  File? image;

  pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  updateProfileImage() async {
    if (image != null) {
      await userController.updateUserProfileImage(image!.path);
      await fetchUser();
      // Update successful, you can show a success message or perform any other actions.
    }
  }

  Future<UserModel>? user;

  fetchUser() async {
    final userData = await u.UserApi().fetchUser();
    setState(() {
      user = Future.value(userData);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            print(snapshot.data?.data);
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              final user = snapshot.data!.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                       Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1,
                          ),
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 35,
                                    child: user.avatar.isNotEmpty
                                        ? CircleAvatar(
                                            radius: 35,
                                            backgroundImage:
                                                FileImage(image!))
                                        : Text(
                                            '${user.firstName[0]} ${user.lastName[0]}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: CustomeColors.blackColor,
                                            ),
                                          ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await pickImage(ImageSource.gallery);
                                        await updateProfileImage();
                                      },
                                      child: const Icon(Icons.camera_alt_rounded)),
                                  // Icon(
                                  //   Icons.add,
                                  //   color: CustomeColors.redColor,
                                  // )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${user.firstName} ${user.lastName}",
                                    style: TextStyle(
                                        fontSize: AppDimentions.mediumFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      pickImage(ImageSource.gallery);
                                    },
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: AppDimentions.smallFontSize,
                                          fontWeight: FontWeight.w500,
                                          color: CustomeColors.redColor),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DocCard(
                                icon: CustomeImages.door,
                                title: "License",
                                onTap: () {
                                  Get.toNamed(AppRouter.uploadlicense);
                                },
                              ),
                              DocCard(
                                icon: CustomeImages.door,
                                title: "NationalID",
                                onTap: () {
                                  Get.toNamed(AppRouter.proofId);
                                },
                              ),
                              DocCard(
                                icon: CustomeImages.door,
                                title: "Other",
                                onTap: () {},
                              )
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.5,
                          ),
                          InkWell(
                            onTap: () async {
                              await LoginController().logOut();
                            },
                            child: Row(
                              children: [
                                ImageIcon(
                                  AssetImage(
                                    CustomeImages.logout,
                                  ),
                                  color: CustomeColors.redColor,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Text(
                                  "Logout",
                                  style:
                                      TextStyle(color: CustomeColors.redColor),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class DocCard extends StatelessWidget {
  final String icon;
  final String title;
  final void Function() onTap;

  const DocCard({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
            color: CustomeColors.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(
              AssetImage(icon),
              size: 20,
              color: CustomeColors.primaryColor,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
