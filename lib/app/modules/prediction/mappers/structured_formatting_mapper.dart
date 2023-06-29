import '../entities/structured_formatting.dart';

class StructuredFormattingMapper {
  static StructuredFormatting fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] ?? '',
      secondaryText: json['secondary_text'] ?? '',
    );
  }
}
