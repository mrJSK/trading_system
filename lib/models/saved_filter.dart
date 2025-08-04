import 'package:isar/isar.dart';

part 'saved_filter.g.dart';

@collection
class SavedFilter {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String name = '';

  double? minMarketCap;
  double? maxMarketCap;
  double? minPE;
  double? maxPE;
  double? minROCE;
  double? maxROCE;
  double? minROE;
  double? maxROE;
  double? minDividendYield;
  double? maxDividendYield;

  DateTime? createdAt;

  SavedFilter();

  SavedFilter.fromData({
    required String name,
    this.minMarketCap,
    this.maxMarketCap,
    this.minPE,
    this.maxPE,
    this.minROCE,
    this.maxROCE,
    this.minROE,
    this.maxROE,
    this.minDividendYield,
    this.maxDividendYield,
    required DateTime createdAt,
  }) {
    this.name = name;
    this.createdAt = createdAt;
  }
}
