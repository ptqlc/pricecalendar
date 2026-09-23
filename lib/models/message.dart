part of 'index.dart';

class MessageModel {
  MessageModel({
    this.timestamp,
    this.isSelf,
    this.content,
  });

  int? timestamp;
  bool? isSelf;
  String? content;

  MessageModel copyWith({
    int? timestamp,
    bool? isSelf,
    String? content,
  }) =>
      MessageModel(
        timestamp: timestamp ?? this.timestamp,
        isSelf: isSelf ?? this.isSelf,
        content: content ?? this.content,
      );
}
