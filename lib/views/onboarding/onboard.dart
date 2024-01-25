import 'package:drivn_customer/utils/export.dart';

class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {

  int index = 0;
 final PageController _pageController = PageController();

  List pages = [
    {
      "img": CustomeImages.onb3,
      "title": "Endless options",
      "description":
          "We offer diverse array of chauffeur drive services. Our chauffeur drive and luxury service allows you to travel in a safe and relaxed way.",
    },
    {
      "img": CustomeImages.onb1,
      "title": "Drive confidently",
      "description":
          "We also provides short-term corporate mini leases from one month to a year.",
    },
    {
      "img": CustomeImages.onb2,
      "title": "24/7 support",
      "description":
          "You can also book our luxury chauffeur drive service for your weddings and special occasions."
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(pages[index]["img"]),
                                fit: BoxFit.cover),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        pages[index]['title'],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: AppDimentions.largeFontSize,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          pages[index]["description"],
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 16, height: 1.5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: pageIndicators(
                        pages: pages, context: context, index: index),
                  ),
                  Row(
                    children: [
                      onbordingButtons(
                        title: index == pages.length - 1 ? "" : "Skip",
                        onTap: () =>
                            _pageController.jumpToPage(pages.length - 1),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      CommonButton(
                        bgd: CustomeColors.primaryColor,
                        title: index == pages.length - 1
                            ? "Get Started"
                            : "Next >>>",
                        onPressed: () => index == pages.length - 1
                            ? Get.toNamed(AppRouter.login)
                            : _pageController.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

GestureDetector onbordingButtons({void Function()? onTap, String? title}) {
  return GestureDetector(
      onTap: onTap,
      child: Text(
        title!,
        style: const TextStyle(fontSize: 16),
      ));
}

List<Widget> pageIndicators({pages, index, BuildContext? context}) {
  List<Container> indicators = [];

  for (int i = 0; i < pages.length; i++) {
    indicators.add(
      Container(
        width: i == index ? 20 : 6,
        height: 6,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color:
              i == index ? CustomeColors.primaryColor : CustomeColors.redColor,
          borderRadius: i == index
              ? BorderRadius.circular(50)
              : BorderRadius.circular(50),
        ),
      ),
    );
  }
  return indicators;
}
