enum CalendarEventType {
  finalCutOff("最終追切", 0xFFFFD033, 0xFFF2C100, 0xFFFFF4C3),
  internCutOff("中間追切", 0xFFFFD033, 0xFFF2C100, 0xFFFFF4C3),
  raceSched("レース予定", 0xFFEA7266, 0xFFE55863, 0xFFFFDFDF),
  farrier("装蹄", 0xFFEA7266, 0xFFE55863, 0xFFFFDFDF),
  stablesRetire("退厩", 0xFF22D143, 0xFF44AD60, 0xFFDCF8E8),
  stablesReturn("帰厩", 0xFF22D143, 0xFF44AD60, 0xFFDCF8E8),
  stableRelated("厩舎関連", 0xFF22D143, 0xFF44AD60, 0xFFDCF8E8),
  businessTrip("出張・不在予定", 0xFF7D79E8, 0xFF736FF1, 0xFFDCDEF8),
  others("その他", 0xFF7D79E8, 0xFF736FF1, 0xFFDCDEF8);

  final String name;
  final int colorDark;
  final int colorDarker;
  final int colorLight;
  const CalendarEventType(
      this.name, this.colorDark, this.colorDarker, this.colorLight);
}
