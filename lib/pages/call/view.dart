part of 'index.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppTheme.setSystemStyle();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.dark,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppTheme.systemStyleDark.copyWith(
          systemNavigationBarColor: const Color(0xFF09101D),
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF09101D),
          body: BuildLayout(
            infoChild: const BuildUserinfo(
              avatar: 'https://api.multiavatar.com/Binx Bond.png',
              nickname: 'Mr Ng',
              status: 'Joining Interview ...',
            ),
            operateChild: BuildOperateBar(
              onAccept: () {},
              onEnd: context.pop,
              onSpeaker: () {},
            ),
          ),
        ),
      ),
    );
  }
}
