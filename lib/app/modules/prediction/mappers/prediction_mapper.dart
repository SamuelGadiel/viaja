import '../entities/prediction.dart';
import 'matched_substring_mapper.dart';
import 'structured_formatting_mapper.dart';
import 'term_mapper.dart';

class PredictionMapper {
  static Prediction fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'] ?? '',
      id: json['id'] ?? '',
      matchedSubstrings: ((json['matched_substrings'] ?? []) as List).map((e) => MatchedSubstringMapper.fromJson(e)).toList(),
      placeId: json['place_id'] ?? '',
      reference: json['reference'] ?? '',
      structuredFormatting: StructuredFormattingMapper.fromJson(json['structured_formatting']),
      terms: ((json['terms'] ?? []) as List).map((e) => TermMapper.fromJson(e)).toList(),
      types: ((json['types'] ?? []) as List).cast<String>(),
      lat: json['lat'] ?? '',
      lng: json['lng'] ?? '',
    );
  }
}
