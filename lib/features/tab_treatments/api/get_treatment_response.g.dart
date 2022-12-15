// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_treatment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTreatmentResponse _$GetTreatmentResponseFromJson(
        Map<String, dynamic> json) =>
    GetTreatmentResponse(
      data: json['data'] == null
          ? null
          : Treatment.fromJson(json['data'] as Map<String, dynamic>),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTreatmentResponseToJson(
        GetTreatmentResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
