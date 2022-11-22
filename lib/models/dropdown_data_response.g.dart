// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropdownDataResponse _$DropdownDataResponseFromJson(
        Map<String, dynamic> json) =>
    DropdownDataResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DropdownData.fromJson(e as Map<String, dynamic>))
          .toList(),
      metaResponse: MetaResponse.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DropdownDataResponseToJson(
        DropdownDataResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'meta': instance.metaResponse,
    };
