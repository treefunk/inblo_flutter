// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      horseId: json['horse_id'] as int?,
      horseName: json['horse_name'] as String?,
      senderId: json['sender_id'] as int?,
      recipientId: json['recipient_id'] as int?,
      title: json['title'] as String?,
      isRead: json['is_read'] as String?,
      notificationType: json['notification_type'] as String?,
      memo: json['memo'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      stableId: json['stable_id'] as int?,
      formattedTime: json['formatted_time'] as String?,
      formattedDate: json['formatted_date'] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      recipient: json['recipient'] == null
          ? null
          : User.fromJson(json['recipient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'horse_id': instance.horseId,
      'horse_name': instance.horseName,
      'sender_id': instance.senderId,
      'recipient_id': instance.recipientId,
      'title': instance.title,
      'is_read': instance.isRead,
      'notification_type': instance.notificationType,
      'memo': instance.memo,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'stable_id': instance.stableId,
      'formatted_time': instance.formattedTime,
      'formatted_date': instance.formattedDate,
      'sender': instance.sender,
      'recipient': instance.recipient,
    };
