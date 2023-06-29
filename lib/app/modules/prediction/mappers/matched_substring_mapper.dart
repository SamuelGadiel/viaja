import '../../../core/extensions/int_extension.dart';
import '../entities/matched_substring.dart';

class MatchedSubstringMapper {
  static MatchedSubstring fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(
      length: json['length'] ?? IntExtension.nan,
      offset: json['offset'] ?? IntExtension.nan,
    );
  }
}
