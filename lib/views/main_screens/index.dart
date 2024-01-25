import 'package:drivn_customer/utils/export.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  bool isSelected = false;

  onTap(index) {
    setState(() {
      currentIndex = index;
      isSelected = true;
    });
  }

  List<Widget> pages = [
    const HomeView(),
    const LikeView(),
    const BookView(),
    ProfileView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // elevation: 0,

          selectedItemColor: CustomeColors.yellowColor,
          unselectedItemColor: CustomeColors.greyColor,
          onTap: onTap,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  CustomeImages.home,
                )),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  CustomeImages.like,
                )),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  CustomeImages.book,
                )),
                label: ""),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                  CustomeImages.profile,
                )),
                label: ""),
          ]),
    );
  }
}
