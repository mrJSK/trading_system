import 'package:isar/isar.dart';

part 'company_data.g.dart';

@collection
class CompanyData {
  Id id = Isar.autoIncrement;

  int? companyId;

  // Basic company information
  String? companyName;
  String? companyDescription;
  String? sector; // NEW: Energy
  String? industry; // NEW: Oil, Gas & Consumable Fuels
  String? subIndustry; // NEW: Petroleum Products
  String? category; // NEW: Refineries & Marketing
  String? pros;
  String? cons;

  // Financial ratios
  double? marketCap;
  double? currentPrice;
  String? highLow;
  double? pe;
  double? pb;
  double? roce;
  double? roe;
  double? dividendYield;
  double? bookValue;
  double? faceValue;

  // Financial tables (as JSON strings)
  String? quarterlyResults;
  String? profitLoss;
  String? balanceSheet;
  String? cashFlows;
  String? ratios;
  String? peerComparison; // NEW: Peer comparison table with sector hierarchy

  DateTime? lastUpdated;

  // Default constructor
  CompanyData();

  // Named constructor for creating instances with data
  CompanyData.fromData({
    this.companyId,
    this.companyName,
    this.companyDescription,
    this.sector, // NEW
    this.industry, // NEW
    this.subIndustry, // NEW
    this.category, // NEW
    this.pros,
    this.cons,
    this.marketCap,
    this.currentPrice,
    this.highLow,
    this.pe,
    this.pb,
    this.roce,
    this.roe,
    this.dividendYield,
    this.bookValue,
    this.faceValue,
    this.quarterlyResults,
    this.profitLoss,
    this.balanceSheet,
    this.cashFlows,
    this.ratios,
    this.peerComparison, // NEW
    this.lastUpdated,
  });

  // Factory constructor for creating from map/JSON
  factory CompanyData.fromMap(Map<String, dynamic> map) {
    return CompanyData.fromData(
      companyId: map['companyId'],
      companyName: map['companyName'],
      companyDescription: map['companyDescription'],
      sector: map['sector'], // NEW
      industry: map['industry'], // NEW
      subIndustry: map['subIndustry'], // NEW
      category: map['category'], // NEW
      pros: map['pros'],
      cons: map['cons'],
      marketCap: map['marketCap']?.toDouble(),
      currentPrice: map['currentPrice']?.toDouble(),
      highLow: map['highLow'],
      pe: map['pe']?.toDouble(),
      pb: map['pb']?.toDouble(),
      roce: map['roce']?.toDouble(),
      roe: map['roe']?.toDouble(),
      dividendYield: map['dividendYield']?.toDouble(),
      bookValue: map['bookValue']?.toDouble(),
      faceValue: map['faceValue']?.toDouble(),
      quarterlyResults: map['quarterlyResults'],
      profitLoss: map['profitLoss'],
      balanceSheet: map['balanceSheet'],
      cashFlows: map['cashFlows'],
      ratios: map['ratios'],
      peerComparison: map['peerComparison'], // NEW
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.tryParse(map['lastUpdated'])
          : null,
    );
  }

  // Convert to map for JSON serialization
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyId': companyId,
      'companyName': companyName,
      'companyDescription': companyDescription,
      'sector': sector, // NEW
      'industry': industry, // NEW
      'subIndustry': subIndustry, // NEW
      'category': category, // NEW
      'pros': pros,
      'cons': cons,
      'marketCap': marketCap,
      'currentPrice': currentPrice,
      'highLow': highLow,
      'pe': pe,
      'pb': pb,
      'roce': roce,
      'roe': roe,
      'dividendYield': dividendYield,
      'bookValue': bookValue,
      'faceValue': faceValue,
      'quarterlyResults': quarterlyResults,
      'profitLoss': profitLoss,
      'balanceSheet': balanceSheet,
      'cashFlows': cashFlows,
      'ratios': ratios,
      'peerComparison': peerComparison, // NEW
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  // Copy method for updating existing instances
  CompanyData copyWith({
    int? companyId,
    String? companyName,
    String? companyDescription,
    String? sector, // NEW
    String? industry, // NEW
    String? subIndustry, // NEW
    String? category, // NEW
    String? pros,
    String? cons,
    double? marketCap,
    double? currentPrice,
    String? highLow,
    double? pe,
    double? pb,
    double? roce,
    double? roe,
    double? dividendYield,
    double? bookValue,
    double? faceValue,
    String? quarterlyResults,
    String? profitLoss,
    String? balanceSheet,
    String? cashFlows,
    String? ratios,
    String? peerComparison, // NEW
    DateTime? lastUpdated,
  }) {
    return CompanyData.fromData(
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyDescription: companyDescription ?? this.companyDescription,
      sector: sector ?? this.sector, // NEW
      industry: industry ?? this.industry, // NEW
      subIndustry: subIndustry ?? this.subIndustry, // NEW
      category: category ?? this.category, // NEW
      pros: pros ?? this.pros,
      cons: cons ?? this.cons,
      marketCap: marketCap ?? this.marketCap,
      currentPrice: currentPrice ?? this.currentPrice,
      highLow: highLow ?? this.highLow,
      pe: pe ?? this.pe,
      pb: pb ?? this.pb,
      roce: roce ?? this.roce,
      roe: roe ?? this.roe,
      dividendYield: dividendYield ?? this.dividendYield,
      bookValue: bookValue ?? this.bookValue,
      faceValue: faceValue ?? this.faceValue,
      quarterlyResults: quarterlyResults ?? this.quarterlyResults,
      profitLoss: profitLoss ?? this.profitLoss,
      balanceSheet: balanceSheet ?? this.balanceSheet,
      cashFlows: cashFlows ?? this.cashFlows,
      ratios: ratios ?? this.ratios,
      peerComparison: peerComparison ?? this.peerComparison, // NEW
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  String toString() {
    return 'CompanyData{id: $id, companyId: $companyId, companyName: $companyName, sector: $sector, marketCap: $marketCap, currentPrice: $currentPrice}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CompanyData && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
