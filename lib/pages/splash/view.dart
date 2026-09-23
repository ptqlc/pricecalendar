part of 'index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      Future.delayed(const Duration(seconds: 2)),
    ]).whenComplete(() {
      if (!mounted) return;
      context.goNamed(Routes.main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: CustomEmpty(
                icon: CustomImage.asset(
                  url: 'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
                title: Text('Find Job'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child: CustomLoadingIndicator()),
          ),
        ],
      ),
    );
  }
}
