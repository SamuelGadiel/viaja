import '../../../core/extensions/int_extension.dart';
import '../entities/term.dart';

class TermMapper {
  static Term fromJson(Map<String, dynamic> json) {
    return Term(
      offset: json['offset'] ?? IntExtension.nan,
      value: json['value'] ?? '',
    );
  }
}
