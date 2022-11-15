import 'user.dart';

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
  final int? horseId;
  final String? horseName;
  final int? senderId;
  final int? recipientId;
  final String? title;
  final String? isRead;
  final String? notificationType;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? stableId;
  final String? formattedTime;
  final String? formattedDate;
  final User? sender;
  final User? recipient;
}
