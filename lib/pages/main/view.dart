part of 'index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    AppTheme.setSystemStyle();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: const [
            CalendarPage(),
            ApplicationPage(),
            ChatPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: GetBuilder<MainController>(
          id: 'navigation',
          builder: (controller) => BottomNavigationBar(
            currentIndex: controller.currentPage,
            onTap: (page) {
              if (page != 0 && !UserStore.to.isLogin) {
                context.pushNamed(Routes.sign);
              } else {
                controller.pageController.jumpToPage(page);
              }
            },
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.calendar_outline),
                activeIcon: Icon(Ionicons.calendar),
                label: '日历',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.apps_outline),
                activeIcon: Icon(Ionicons.apps),
                label: '黄历',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.chatbubbles_outline),
                activeIcon: Icon(Ionicons.chatbubbles),
                label: '天气',
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.person_outline),
                activeIcon: Icon(Ionicons.person),
                label: '我的',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
