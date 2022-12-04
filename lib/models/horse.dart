import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'stable.dart';
import 'user.dart';

part 'horse.g.dart';

@JsonSerializable()
class Horse {
  Horse({
    this.id,
    this.stableId,
    this.ownerId,
    this.userId,
    this.farmId,
    this.trainingFarmId,
    this.birthDate,
    this.sex,
    this.name,
    this.color,
    this.horseClass,
    this.fatherName,
    this.motherName,
    this.motherFatherName,
    this.totalStake,
    this.stableName,
    this.ownerName,
    this.farmName,
    this.trainingFarmName,
    this.memo,
    this.createdAt,
    this.updatedAt,
    this.archivedAt,
    this.age,
    this.user,
    this.stable,
  });

  int? id;

  @JsonKey(name: "stable_id")
  int? stableId;

  @JsonKey(name: "owner_id")
  int? ownerId;

  @JsonKey(name: "user_id")
  int? userId;

  @JsonKey(name: "farm_id")
  int? farmId;

  @JsonKey(name: "training_farm_id")
  int? trainingFarmId;

  @JsonKey(name: "birth_date")
  DateTime? birthDate;

  @JsonKey(name: "sex")
  String? sex;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "color")
  String? color;

  @JsonKey(name: "class")
  String? horseClass;

  @JsonKey(name: "father_name")
  String? fatherName;

  @JsonKey(name: "mother_name")
  String? motherName;

  @JsonKey(name: "mother_father_name")
  String? motherFatherName;

  @JsonKey(name: "total_stake")
  double? totalStake;

  @JsonKey(name: "stable_name")
  String? stableName;

  @JsonKey(name: "owner_name")
  String? ownerName;

  @JsonKey(name: "farm_name")
  String? farmName;

  @JsonKey(name: "training_farm_name")
  String? trainingFarmName;

  @JsonKey(name: "memo")
  String? memo;

  @JsonKey(name: "created_at")
  DateTime? createdAt;

  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  @JsonKey(name: "archived_at")
  DateTime? archivedAt;

  @JsonKey(name: "age")
  int? age;

  @JsonKey(name: "user")
  User? user;

  @JsonKey(name: "stable")
  Stable? stable;

  String get getGenderAndAge {
    String str = "";
    str += (sex ?? "");
    if (age != -1) {
      str += age.toString();
    }
    return str;
  }

  String? get getBirthDateOnly {
    var dateFormat = "y-MM-dd";
    if (birthDate != null) {
      var formattedDateString = DateFormat(dateFormat).format(birthDate!);
      return formattedDateString;
    }
    return null;
  }

  factory Horse.fromJson(Map<String, dynamic> json) => _$HorseFromJson(json);

  Map<String, dynamic> toJson() => _$HorseToJson(this);
}
