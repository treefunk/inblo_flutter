// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreatmentListResponse _$TreatmentListResponseFromJson(
        Map<String, dynamic> json) =>
    TreatmentListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Treatment.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TreatmentListResponseToJson(
        TreatmentListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
