import 'matched_substring.dart';
import 'structured_formatting.dart';
import 'term.dart';

class Prediction {
  String description;
  String id;
  List<MatchedSubstring> matchedSubstrings;
  String placeId;
  String reference;
  StructuredFormatting structuredFormatting;
  List<Term> terms;
  List<String> types;
  String lat;
  String lng;

  Prediction({
    required this.description,
    required this.id,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
    required this.lat,
    required this.lng,
  });
}
