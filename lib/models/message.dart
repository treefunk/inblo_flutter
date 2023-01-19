import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message({
    this.id,
    this.horseId,
    this.horseName,
    this.senderId,
    this.recipientId,
    this.title,
    this.isRead,
    this.notificationType,
    this.memo,
    this.createdAt,
    this.updatedAt,
    this.stableId,
    this.formattedTime,
    this.formattedDate,
    this.sender,
    this.recipient,
  });

  final int? id;

  @JsonKey(name: "horse_id")
  final int? horseId;

  @JsonKey(name: "horse_name")
  final String? horseName;

  @JsonKey(name: "sender_id")
  final int? senderId;

  @JsonKey(name: "recipient_id")
  final int? recipientId;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "is_read")
  final String? isRead;

  @JsonKey(name: "notification_type")
  final String? notificationType;

  final String? memo;

  @JsonKey(name: "created_at")
  final DateTime? createdAt;

  @JsonKey(name: "updated_at")
  final DateTime? updatedAt;

  @JsonKey(name: "stable_id")
  final int? stableId;

  @JsonKey(name: "formatted_time")
  final String? formattedTime;

  @JsonKey(name: "formatted_date")
  final String? formattedDate;

  @JsonKey(name: "sender")
  final User? sender;

  @JsonKey(name: "recipient")
  final User? recipient;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
