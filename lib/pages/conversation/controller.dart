part of 'index.dart';

class ConversationController extends GetxController {
  final TextEditingController textInput = TextEditingController();
  final List<MessageModel> messageList = [];

  @override
  void onInit() {
    super.onInit();
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 24, 9, 36).millisecondsSinceEpoch,
      content: 'Fine and what about you?',
      isSelf: true,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 24, 9, 39).millisecondsSinceEpoch,
      content: 'I am fine too',
      isSelf: false,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 25, 14, 12).millisecondsSinceEpoch,
      content: 'Hey you do you wanna go to the cinema?',
      isSelf: true,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 25, 14, 19).millisecondsSinceEpoch,
      content: 'Yes of course when do we want to meet',
      isSelf: false,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 25, 14, 20).millisecondsSinceEpoch,
      content: 'Lets meet at 8 o clock',
      isSelf: true,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 25, 14, 25).millisecondsSinceEpoch,
      content: 'Okay see you then :)',
      isSelf: false,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 27, 18, 45).millisecondsSinceEpoch,
      content: 'Of course what do you need?',
      isSelf: true,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 28, 8, 47).millisecondsSinceEpoch,
      content: 'Can you send me the homework for tomorrow please?',
      isSelf: false,
    ));
    messageList.add(MessageModel(
      timestamp: DateTime(2020, 6, 28, 8, 48).millisecondsSinceEpoch,
      content: 'I dont understand the math questions :(',
      isSelf: true,
    ));
  }

  void sendText() {
    if (textInput.value.text.trim().isEmpty) return;
    messageList.add(MessageModel(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      content: textInput.value.text,
      isSelf: true,
    ));
    textInput.clear();
    update(['message_list']);
  }
}

