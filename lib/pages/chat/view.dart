part of 'index.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Chat Box'),
      ),
      body: CustomListScrollView(
        minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
        builder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: CustomCard.chat(
              avatar: 'https://api.multiavatar.com/Binx Bond.png',
              nickname: const Text('Mr Ng'),
              label: const Text('That’s awesome!'),
              count: index == 0 ? 13 : 0,
              timestamp: DateTime.now().millisecondsSinceEpoch,
              onTap: () => context.pushNamed(Routes.conversation),
            ),
          );
        },
        childCount: 4,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
