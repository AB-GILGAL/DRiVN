import 'package:drivn_customer/utils/export.dart';

class LikeView extends StatefulWidget {
  const LikeView({super.key});

  @override
  State<LikeView> createState() => _LikeViewState();
}

class _LikeViewState extends State<LikeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomeColors.bgdColor,
        title: const Text(
          "Favorites",
          style: TextStyle(
            color: CustomeColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.13,
                      width: MediaQuery.of(context).size.width * 0.32,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(CustomeImages.car2),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.05,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mercedes-Benz",
                          style: TextStyle(
                              fontSize: AppDimentions.mediumFontSize,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.005,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: CustomeColors.yellowColor,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: CustomeColors.yellowColor,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: CustomeColors.yellowColor,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: CustomeColors.yellowColor,
                              size: 20,
                            ),
                            Icon(
                              Icons.star,
                              color: CustomeColors.yellowColor,
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.005,
                        ),
                        Text(
                          "5 Seater",
                          style: TextStyle(
                              fontSize: AppDimentions.smallFontSize,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.005,
                        ),
                        Text(
                          "\$200/Hour",
                          style: TextStyle(
                              fontSize: AppDimentions.smallFontSize,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
