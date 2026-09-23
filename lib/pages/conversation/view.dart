part of 'index.dart';

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  int _groupComparator(DateTime left, DateTime right) {
    final leftTimestamp = left.millisecondsSinceEpoch;
    final rightTimestamp = right.millisecondsSinceEpoch;
    return rightTimestamp.compareTo(leftTimestamp);
  }

  int _itemComparator(MessageModel left, MessageModel right) {
    final leftTimestamp = left.timestamp ?? 0;
    final rightTimestamp = right.timestamp ?? 0;
    return rightTimestamp.compareTo(leftTimestamp);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationController>(
      init: ConversationController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: CustomAppBar(
            centerTitle: false,
            titleSpacing: 0,
            title: const BuildUserinfo(
              avatar: 'https://api.multiavatar.com/Binx Bond.png',
              nickname: 'Mr Ng',
              status: 'Online',
            ),
            actions: [
              CustomButton.icon(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                icon: const Icon(Ionicons.videocam),
                onPressed: () => context.pushNamed(Routes.call),
              ),
              CustomButton.icon(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                icon: const Icon(Ionicons.call),
                onPressed: () => context.pushNamed(Routes.call),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GetBuilder<ConversationController>(
                  id: 'message_list',
                  builder: (controller) {
                    return BuildMessageList<MessageModel, DateTime>(
                      items: controller.messageList,
                      groupBy: (value) {
                        return Date.fromMilli(value.timestamp) ??
                            DateTime.now();
                      },
                      groupRange: (left, right) {
                        return left.difference(right).inMinutes <= 5;
                      },
                      groupComparator: _groupComparator,
                      itemComparator: _itemComparator,
                      groupHeaderBuilder: (value) => BuildMessageTime(
                        timestamp: value.timestamp ?? 0,
                      ),
                      itemBuilder: (_, value) => BuildMessage(
                        isSelf: (value.isSelf ?? false),
                        text: value.content,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: BuildOperateBar(
            textInput: controller.textInput,
            onSendText: controller.sendText,
          ),
        ),
      ),
    );
  }
}

class Element {
  DateTime date;
  String text;
  bool sender = false;

  Element(this.date, this.text, [this.sender = false]);
}
