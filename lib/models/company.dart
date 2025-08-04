import 'package:isar/isar.dart';

part 'company.g.dart';

@collection
class Company {
  Id id = Isar.autoIncrement;

  @Index()
  String name = '';

  @Index(unique: true)
  String url = '';

  @Index()
  String symbol = '';

  double? currentPrice;
  double? marketCap;
  DateTime? lastUpdated;

  // Default constructor
  Company();

  // Named constructor for creating instances with data
  Company.fromData({
    required String name,
    required String url,
    required String symbol,
    this.currentPrice,
    this.marketCap,
    this.lastUpdated,
  }) {
    this.name = name;
    this.url = url;
    this.symbol = symbol;
  }

  // Factory constructor for creating from map/JSON
  factory Company.fromMap(Map<String, dynamic> map) {
    return Company.fromData(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      symbol: map['symbol'] ?? '',
      currentPrice: map['currentPrice']?.toDouble(),
      marketCap: map['marketCap']?.toDouble(),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated'])
          : null,
    );
  }

  // Convert to map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'symbol': symbol,
      'currentPrice': currentPrice,
      'marketCap': marketCap,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // Copy method for updating existing instances
  Company copyWith({
    String? name,
    String? url,
    String? symbol,
    double? currentPrice,
    double? marketCap,
    DateTime? lastUpdated,
  }) {
    return Company.fromData(
      name: name ?? this.name,
      url: url ?? this.url,
      symbol: symbol ?? this.symbol,
      currentPrice: currentPrice ?? this.currentPrice,
      marketCap: marketCap ?? this.marketCap,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  String toString() {
    return 'Company{id: $id, name: $name, symbol: $symbol, currentPrice: $currentPrice, marketCap: $marketCap}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Company && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // Helper methods
  bool get hasValidPrice => currentPrice != null && currentPrice! > 0;
  bool get hasValidMarketCap => marketCap != null && marketCap! > 0;
  bool get isRecentlyUpdated =>
      lastUpdated != null && DateTime.now().difference(lastUpdated!).inDays < 7;

  // Format current price as currency
  String get formattedPrice =>
      currentPrice != null ? '₹${currentPrice!.toStringAsFixed(2)}' : 'N/A';

  // Format market cap in crores
  String get formattedMarketCap =>
      marketCap != null ? '₹${marketCap!.toStringAsFixed(0)} Cr' : 'N/A';

  // Get company URL for Screener.in
  String get screenerUrl =>
      url.startsWith('http') ? url : 'https://www.screener.in$url';
}
