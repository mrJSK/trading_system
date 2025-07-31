// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      about: json['about'] as String?,
      website: json['website'] as String?,
      bseCode: json['bseCode'] as String?,
      nseCode: json['nseCode'] as String?,
      marketCap: (json['marketCap'] as num?)?.toDouble(),
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      highLow: json['highLow'] as String?,
      stockPe: (json['stockPe'] as num?)?.toDouble(),
      bookValue: (json['bookValue'] as num?)?.toDouble(),
      dividendYield: (json['dividendYield'] as num?)?.toDouble(),
      roce: (json['roce'] as num?)?.toDouble(),
      roe: (json['roe'] as num?)?.toDouble(),
      faceValue: (json['faceValue'] as num?)?.toDouble(),
      pros:
          (json['pros'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      cons:
          (json['cons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      lastUpdated: const TimestampConverter().fromJson(json['lastUpdated']),
      ratiosData: json['ratiosData'] as Map<String, dynamic>? ?? const {},
      changePercent: (json['changePercent'] as num?)?.toDouble() ?? 0.0,
      changeAmount: (json['changeAmount'] as num?)?.toDouble() ?? 0.0,
      previousClose: (json['previousClose'] as num?)?.toDouble() ?? 0.0,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      quarterlyResults: json['quarterlyResults'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['quarterlyResults'] as Map<String, dynamic>),
      profitLossStatement: json['profitLossStatement'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['profitLossStatement'] as Map<String, dynamic>),
      balanceSheet: json['balanceSheet'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['balanceSheet'] as Map<String, dynamic>),
      cashFlowStatement: json['cashFlowStatement'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['cashFlowStatement'] as Map<String, dynamic>),
      ratios: json['ratios'] == null
          ? null
          : FinancialDataModel.fromJson(json['ratios'] as Map<String, dynamic>),
      industryClassification: (json['industryClassification'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shareholdingPattern: json['shareholdingPattern'] == null
          ? null
          : ShareholdingPattern.fromJson(
              json['shareholdingPattern'] as Map<String, dynamic>),
      growthTables: json['growthTables'] as Map<String, dynamic>? ?? const {},
      salesGrowth: (json['salesGrowth'] as num?)?.toDouble(),
      profitGrowth: (json['profitGrowth'] as num?)?.toDouble(),
      operatingMargin: (json['operatingMargin'] as num?)?.toDouble(),
      netMargin: (json['netMargin'] as num?)?.toDouble(),
      assetTurnover: (json['assetTurnover'] as num?)?.toDouble(),
      workingCapital: (json['workingCapital'] as num?)?.toDouble(),
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
      currentRatio: (json['currentRatio'] as num?)?.toDouble(),
      quickRatio: (json['quickRatio'] as num?)?.toDouble(),
      interestCoverage: (json['interestCoverage'] as num?)?.toDouble(),
      priceToBook: (json['priceToBook'] as num?)?.toDouble(),
      evToEbitda: (json['evToEbitda'] as num?)?.toDouble(),
      pegRatio: (json['pegRatio'] as num?)?.toDouble(),
      enterpriseValue: (json['enterpriseValue'] as num?)?.toDouble(),
      earningsPerShare: (json['earningsPerShare'] as num?)?.toDouble(),
      cashPerShare: (json['cashPerShare'] as num?)?.toDouble(),
      salesPerShare: (json['salesPerShare'] as num?)?.toDouble(),
      returnOnAssets: (json['returnOnAssets'] as num?)?.toDouble(),
      returnOnCapitalEmployed:
          (json['returnOnCapitalEmployed'] as num?)?.toDouble(),
      returnOnEquity: (json['returnOnEquity'] as num?)?.toDouble(),
      sector: json['sector'] as String?,
      industry: json['industry'] as String?,
      beta: (json['beta'] as num?)?.toDouble(),
      sharesOutstanding: (json['sharesOutstanding'] as num?)?.toInt(),
      promoterHolding: (json['promoterHolding'] as num?)?.toDouble(),
      publicHolding: (json['publicHolding'] as num?)?.toDouble(),
      dayHigh: (json['dayHigh'] as num?)?.toDouble(),
      dayLow: (json['dayLow'] as num?)?.toDouble(),
      weekHigh52: (json['weekHigh52'] as num?)?.toDouble(),
      weekLow52: (json['weekLow52'] as num?)?.toDouble(),
      averageVolume: (json['averageVolume'] as num?)?.toDouble(),
      marketLot: (json['marketLot'] as num?)?.toDouble(),
      dividendPerShare: (json['dividendPerShare'] as num?)?.toDouble(),
      exDividendDate: json['exDividendDate'] == null
          ? null
          : DateTime.parse(json['exDividendDate'] as String),
      recordDate: json['recordDate'] == null
          ? null
          : DateTime.parse(json['recordDate'] as String),
      corporateActions: (json['corporateActions'] as List<dynamic>?)
              ?.map((e) => CorporateAction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentNews: (json['recentNews'] as List<dynamic>?)
              ?.map((e) => CompanyNews.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      analystRecommendations: json['analystRecommendations'] == null
          ? null
          : AnalystRecommendations.fromJson(
              json['analystRecommendations'] as Map<String, dynamic>),
      peerCompanies: (json['peerCompanies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      esgScores: json['esgScores'] == null
          ? null
          : ESGScores.fromJson(json['esgScores'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'about': instance.about,
      'website': instance.website,
      'bseCode': instance.bseCode,
      'nseCode': instance.nseCode,
      'marketCap': instance.marketCap,
      'currentPrice': instance.currentPrice,
      'highLow': instance.highLow,
      'stockPe': instance.stockPe,
      'bookValue': instance.bookValue,
      'dividendYield': instance.dividendYield,
      'roce': instance.roce,
      'roe': instance.roe,
      'faceValue': instance.faceValue,
      'pros': instance.pros,
      'cons': instance.cons,
      'lastUpdated': const TimestampConverter().toJson(instance.lastUpdated),
      'ratiosData': instance.ratiosData,
      'changePercent': instance.changePercent,
      'changeAmount': instance.changeAmount,
      'previousClose': instance.previousClose,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'quarterlyResults': instance.quarterlyResults,
      'profitLossStatement': instance.profitLossStatement,
      'balanceSheet': instance.balanceSheet,
      'cashFlowStatement': instance.cashFlowStatement,
      'ratios': instance.ratios,
      'industryClassification': instance.industryClassification,
      'shareholdingPattern': instance.shareholdingPattern,
      'growthTables': instance.growthTables,
      'salesGrowth': instance.salesGrowth,
      'profitGrowth': instance.profitGrowth,
      'operatingMargin': instance.operatingMargin,
      'netMargin': instance.netMargin,
      'assetTurnover': instance.assetTurnover,
      'workingCapital': instance.workingCapital,
      'debtToEquity': instance.debtToEquity,
      'currentRatio': instance.currentRatio,
      'quickRatio': instance.quickRatio,
      'interestCoverage': instance.interestCoverage,
      'priceToBook': instance.priceToBook,
      'evToEbitda': instance.evToEbitda,
      'pegRatio': instance.pegRatio,
      'enterpriseValue': instance.enterpriseValue,
      'earningsPerShare': instance.earningsPerShare,
      'cashPerShare': instance.cashPerShare,
      'salesPerShare': instance.salesPerShare,
      'returnOnAssets': instance.returnOnAssets,
      'returnOnCapitalEmployed': instance.returnOnCapitalEmployed,
      'returnOnEquity': instance.returnOnEquity,
      'sector': instance.sector,
      'industry': instance.industry,
      'beta': instance.beta,
      'sharesOutstanding': instance.sharesOutstanding,
      'promoterHolding': instance.promoterHolding,
      'publicHolding': instance.publicHolding,
      'dayHigh': instance.dayHigh,
      'dayLow': instance.dayLow,
      'weekHigh52': instance.weekHigh52,
      'weekLow52': instance.weekLow52,
      'averageVolume': instance.averageVolume,
      'marketLot': instance.marketLot,
      'dividendPerShare': instance.dividendPerShare,
      'exDividendDate': instance.exDividendDate?.toIso8601String(),
      'recordDate': instance.recordDate?.toIso8601String(),
      'corporateActions': instance.corporateActions,
      'recentNews': instance.recentNews,
      'analystRecommendations': instance.analystRecommendations,
      'peerCompanies': instance.peerCompanies,
      'esgScores': instance.esgScores,
    };

_$ShareholdingPatternImpl _$$ShareholdingPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$ShareholdingPatternImpl(
      quarterly: (json['quarterly'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ShareholdingPatternImplToJson(
        _$ShareholdingPatternImpl instance) =>
    <String, dynamic>{
      'quarterly': instance.quarterly,
    };

_$CorporateActionImpl _$$CorporateActionImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateActionImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      exDate: json['exDate'] == null
          ? null
          : DateTime.parse(json['exDate'] as String),
      recordDate: json['recordDate'] == null
          ? null
          : DateTime.parse(json['recordDate'] as String),
      ratio: json['ratio'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CorporateActionImplToJson(
        _$CorporateActionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'exDate': instance.exDate?.toIso8601String(),
      'recordDate': instance.recordDate?.toIso8601String(),
      'ratio': instance.ratio,
      'amount': instance.amount,
    };

_$CompanyNewsImpl _$$CompanyNewsImplFromJson(Map<String, dynamic> json) =>
    _$CompanyNewsImpl(
      title: json['title'] as String,
      summary: json['summary'] as String?,
      url: json['url'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$$CompanyNewsImplToJson(_$CompanyNewsImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'summary': instance.summary,
      'url': instance.url,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'source': instance.source,
    };

_$AnalystRecommendationsImpl _$$AnalystRecommendationsImplFromJson(
        Map<String, dynamic> json) =>
    _$AnalystRecommendationsImpl(
      strongBuy: (json['strongBuy'] as num?)?.toInt() ?? 0,
      buy: (json['buy'] as num?)?.toInt() ?? 0,
      hold: (json['hold'] as num?)?.toInt() ?? 0,
      sell: (json['sell'] as num?)?.toInt() ?? 0,
      strongSell: (json['strongSell'] as num?)?.toInt() ?? 0,
      averageTargetPrice: (json['averageTargetPrice'] as num?)?.toDouble(),
      highTargetPrice: (json['highTargetPrice'] as num?)?.toDouble(),
      lowTargetPrice: (json['lowTargetPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AnalystRecommendationsImplToJson(
        _$AnalystRecommendationsImpl instance) =>
    <String, dynamic>{
      'strongBuy': instance.strongBuy,
      'buy': instance.buy,
      'hold': instance.hold,
      'sell': instance.sell,
      'strongSell': instance.strongSell,
      'averageTargetPrice': instance.averageTargetPrice,
      'highTargetPrice': instance.highTargetPrice,
      'lowTargetPrice': instance.lowTargetPrice,
    };

_$ESGScoresImpl _$$ESGScoresImplFromJson(Map<String, dynamic> json) =>
    _$ESGScoresImpl(
      environmental: (json['environmental'] as num?)?.toDouble(),
      social: (json['social'] as num?)?.toDouble(),
      governance: (json['governance'] as num?)?.toDouble(),
      overall: (json['overall'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ESGScoresImplToJson(_$ESGScoresImpl instance) =>
    <String, dynamic>{
      'environmental': instance.environmental,
      'social': instance.social,
      'governance': instance.governance,
      'overall': instance.overall,
    };

_$StockPriceImpl _$$StockPriceImplFromJson(Map<String, dynamic> json) =>
    _$StockPriceImpl(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      open: (json['open'] as num?)?.toDouble(),
      previousClose: (json['previousClose'] as num?)?.toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$StockPriceImplToJson(_$StockPriceImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'change': instance.change,
      'changePercent': instance.changePercent,
      'volume': instance.volume,
      'high': instance.high,
      'low': instance.low,
      'open': instance.open,
      'previousClose': instance.previousClose,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$WatchlistItemImpl _$$WatchlistItemImplFromJson(Map<String, dynamic> json) =>
    _$WatchlistItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      targetPrice: (json['targetPrice'] as num?)?.toDouble(),
      stopLoss: (json['stopLoss'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$WatchlistItemImplToJson(_$WatchlistItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'targetPrice': instance.targetPrice,
      'stopLoss': instance.stopLoss,
      'notes': instance.notes,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
