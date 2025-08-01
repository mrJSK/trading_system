// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
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
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      lastUpdated: json['lastUpdated'] as String,
      changePercent: (json['changePercent'] as num?)?.toDouble() ?? 0.0,
      changeAmount: (json['changeAmount'] as num?)?.toDouble() ?? 0.0,
      previousClose: (json['previousClose'] as num?)?.toDouble() ?? 0.0,
      quarterlyResults: const FinancialDataModelConverter()
          .fromJson(json['quarterlyResults']),
      profitLossStatement: const FinancialDataModelConverter()
          .fromJson(json['profitLossStatement']),
      balanceSheet:
          const FinancialDataModelConverter().fromJson(json['balanceSheet']),
      cashFlowStatement: const FinancialDataModelConverter()
          .fromJson(json['cashFlowStatement']),
      ratios: const FinancialDataModelConverter().fromJson(json['ratios']),
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
      currentRatio: (json['currentRatio'] as num?)?.toDouble(),
      quickRatio: (json['quickRatio'] as num?)?.toDouble(),
      interestCoverage: (json['interestCoverage'] as num?)?.toDouble(),
      assetTurnover: (json['assetTurnover'] as num?)?.toDouble(),
      inventoryTurnover: (json['inventoryTurnover'] as num?)?.toDouble(),
      receivablesTurnover: (json['receivablesTurnover'] as num?)?.toDouble(),
      payablesTurnover: (json['payablesTurnover'] as num?)?.toDouble(),
      workingCapital: (json['workingCapital'] as num?)?.toDouble(),
      enterpriseValue: (json['enterpriseValue'] as num?)?.toDouble(),
      evEbitda: (json['evEbitda'] as num?)?.toDouble(),
      priceToBook: (json['priceToBook'] as num?)?.toDouble(),
      priceToSales: (json['priceToSales'] as num?)?.toDouble(),
      pegRatio: (json['pegRatio'] as num?)?.toDouble(),
      betaValue: (json['betaValue'] as num?)?.toDouble(),
      salesGrowth1Y: (json['salesGrowth1Y'] as num?)?.toDouble(),
      salesGrowth3Y: (json['salesGrowth3Y'] as num?)?.toDouble(),
      salesGrowth5Y: (json['salesGrowth5Y'] as num?)?.toDouble(),
      profitGrowth1Y: (json['profitGrowth1Y'] as num?)?.toDouble(),
      profitGrowth3Y: (json['profitGrowth3Y'] as num?)?.toDouble(),
      profitGrowth5Y: (json['profitGrowth5Y'] as num?)?.toDouble(),
      salesCAGR3Y: (json['salesCAGR3Y'] as num?)?.toDouble(),
      salesCAGR5Y: (json['salesCAGR5Y'] as num?)?.toDouble(),
      profitCAGR3Y: (json['profitCAGR3Y'] as num?)?.toDouble(),
      profitCAGR5Y: (json['profitCAGR5Y'] as num?)?.toDouble(),
      piotroskiScore: (json['piotroskiScore'] as num?)?.toDouble(),
      altmanZScore: (json['altmanZScore'] as num?)?.toDouble(),
      creditRating: json['creditRating'] as String?,
      sector: json['sector'] as String?,
      industry: json['industry'] as String?,
      industryClassification: (json['industryClassification'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shareholdingPattern: const ShareholdingPatternConverter()
          .fromJson(json['shareholdingPattern']),
      ratiosData: json['ratiosData'] as Map<String, dynamic>? ?? const {},
      growthTables: (json['growthTables'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
      quarterlyDataHistory: (json['quarterlyDataHistory'] as List<dynamic>?)
              ?.map((e) => QuarterlyData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      annualDataHistory: (json['annualDataHistory'] as List<dynamic>?)
              ?.map((e) => AnnualData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      peerCompanies: (json['peerCompanies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sectorPE: (json['sectorPE'] as num?)?.toDouble(),
      sectorROE: (json['sectorROE'] as num?)?.toDouble(),
      sectorDebtToEquity: (json['sectorDebtToEquity'] as num?)?.toDouble(),
      dividendPerShare: (json['dividendPerShare'] as num?)?.toDouble(),
      dividendFrequency: json['dividendFrequency'] as String?,
      dividendHistory: (json['dividendHistory'] as List<dynamic>?)
              ?.map((e) => DividendHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      keyManagement: (json['keyManagement'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      promoterHolding: (json['promoterHolding'] as num?)?.toDouble(),
      institutionalHolding: (json['institutionalHolding'] as num?)?.toDouble(),
      publicHolding: (json['publicHolding'] as num?)?.toDouble(),
      volatility30D: (json['volatility30D'] as num?)?.toDouble(),
      volatility1Y: (json['volatility1Y'] as num?)?.toDouble(),
      maxDrawdown: (json['maxDrawdown'] as num?)?.toDouble(),
      sharpeRatio: (json['sharpeRatio'] as num?)?.toDouble(),
      marketCapCategory: (json['marketCapCategory'] as num?)?.toDouble(),
      isIndexConstituent: json['isIndexConstituent'] as bool?,
      indices: (json['indices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      rsi: (json['rsi'] as num?)?.toDouble(),
      sma50: (json['sma50'] as num?)?.toDouble(),
      sma200: (json['sma200'] as num?)?.toDouble(),
      ema12: (json['ema12'] as num?)?.toDouble(),
      ema26: (json['ema26'] as num?)?.toDouble(),
      isDebtFree: json['isDebtFree'] as bool? ?? false,
      isProfitable: json['isProfitable'] as bool? ?? false,
      hasConsistentProfits: json['hasConsistentProfits'] as bool? ?? false,
      paysDividends: json['paysDividends'] as bool? ?? false,
      isGrowthStock: json['isGrowthStock'] as bool? ?? false,
      isValueStock: json['isValueStock'] as bool? ?? false,
      isQualityStock: json['isQualityStock'] as bool? ?? false,
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'displayName': instance.displayName,
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
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastUpdated': instance.lastUpdated,
      'changePercent': instance.changePercent,
      'changeAmount': instance.changeAmount,
      'previousClose': instance.previousClose,
      'quarterlyResults':
          const FinancialDataModelConverter().toJson(instance.quarterlyResults),
      'profitLossStatement': const FinancialDataModelConverter()
          .toJson(instance.profitLossStatement),
      'balanceSheet':
          const FinancialDataModelConverter().toJson(instance.balanceSheet),
      'cashFlowStatement': const FinancialDataModelConverter()
          .toJson(instance.cashFlowStatement),
      'ratios': const FinancialDataModelConverter().toJson(instance.ratios),
      'debtToEquity': instance.debtToEquity,
      'currentRatio': instance.currentRatio,
      'quickRatio': instance.quickRatio,
      'interestCoverage': instance.interestCoverage,
      'assetTurnover': instance.assetTurnover,
      'inventoryTurnover': instance.inventoryTurnover,
      'receivablesTurnover': instance.receivablesTurnover,
      'payablesTurnover': instance.payablesTurnover,
      'workingCapital': instance.workingCapital,
      'enterpriseValue': instance.enterpriseValue,
      'evEbitda': instance.evEbitda,
      'priceToBook': instance.priceToBook,
      'priceToSales': instance.priceToSales,
      'pegRatio': instance.pegRatio,
      'betaValue': instance.betaValue,
      'salesGrowth1Y': instance.salesGrowth1Y,
      'salesGrowth3Y': instance.salesGrowth3Y,
      'salesGrowth5Y': instance.salesGrowth5Y,
      'profitGrowth1Y': instance.profitGrowth1Y,
      'profitGrowth3Y': instance.profitGrowth3Y,
      'profitGrowth5Y': instance.profitGrowth5Y,
      'salesCAGR3Y': instance.salesCAGR3Y,
      'salesCAGR5Y': instance.salesCAGR5Y,
      'profitCAGR3Y': instance.profitCAGR3Y,
      'profitCAGR5Y': instance.profitCAGR5Y,
      'piotroskiScore': instance.piotroskiScore,
      'altmanZScore': instance.altmanZScore,
      'creditRating': instance.creditRating,
      'sector': instance.sector,
      'industry': instance.industry,
      'industryClassification': instance.industryClassification,
      'shareholdingPattern': const ShareholdingPatternConverter()
          .toJson(instance.shareholdingPattern),
      'ratiosData': instance.ratiosData,
      'growthTables': instance.growthTables,
      'quarterlyDataHistory': instance.quarterlyDataHistory,
      'annualDataHistory': instance.annualDataHistory,
      'peerCompanies': instance.peerCompanies,
      'sectorPE': instance.sectorPE,
      'sectorROE': instance.sectorROE,
      'sectorDebtToEquity': instance.sectorDebtToEquity,
      'dividendPerShare': instance.dividendPerShare,
      'dividendFrequency': instance.dividendFrequency,
      'dividendHistory': instance.dividendHistory,
      'keyManagement': instance.keyManagement,
      'promoterHolding': instance.promoterHolding,
      'institutionalHolding': instance.institutionalHolding,
      'publicHolding': instance.publicHolding,
      'volatility30D': instance.volatility30D,
      'volatility1Y': instance.volatility1Y,
      'maxDrawdown': instance.maxDrawdown,
      'sharpeRatio': instance.sharpeRatio,
      'marketCapCategory': instance.marketCapCategory,
      'isIndexConstituent': instance.isIndexConstituent,
      'indices': instance.indices,
      'rsi': instance.rsi,
      'sma50': instance.sma50,
      'sma200': instance.sma200,
      'ema12': instance.ema12,
      'ema26': instance.ema26,
      'isDebtFree': instance.isDebtFree,
      'isProfitable': instance.isProfitable,
      'hasConsistentProfits': instance.hasConsistentProfits,
      'paysDividends': instance.paysDividends,
      'isGrowthStock': instance.isGrowthStock,
      'isValueStock': instance.isValueStock,
      'isQualityStock': instance.isQualityStock,
    };

_$QuarterlyDataImpl _$$QuarterlyDataImplFromJson(Map<String, dynamic> json) =>
    _$QuarterlyDataImpl(
      quarter: json['quarter'] as String,
      year: json['year'] as String,
      sales: (json['sales'] as num?)?.toDouble(),
      netProfit: (json['netProfit'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      operatingProfit: (json['operatingProfit'] as num?)?.toDouble(),
      ebitda: (json['ebitda'] as num?)?.toDouble(),
      totalIncome: (json['totalIncome'] as num?)?.toDouble(),
      totalExpenses: (json['totalExpenses'] as num?)?.toDouble(),
      otherIncome: (json['otherIncome'] as num?)?.toDouble(),
      rawMaterials: (json['rawMaterials'] as num?)?.toDouble(),
      powerAndFuel: (json['powerAndFuel'] as num?)?.toDouble(),
      employeeCost: (json['employeeCost'] as num?)?.toDouble(),
      sellingExpenses: (json['sellingExpenses'] as num?)?.toDouble(),
      adminExpenses: (json['adminExpenses'] as num?)?.toDouble(),
      researchAndDevelopment:
          (json['researchAndDevelopment'] as num?)?.toDouble(),
      depreciation: (json['depreciation'] as num?)?.toDouble(),
      interestExpense: (json['interestExpense'] as num?)?.toDouble(),
      taxExpense: (json['taxExpense'] as num?)?.toDouble(),
      reportDate: const TimestampConverter().fromJson(json['reportDate']),
    );

Map<String, dynamic> _$$QuarterlyDataImplToJson(_$QuarterlyDataImpl instance) =>
    <String, dynamic>{
      'quarter': instance.quarter,
      'year': instance.year,
      'sales': instance.sales,
      'netProfit': instance.netProfit,
      'eps': instance.eps,
      'operatingProfit': instance.operatingProfit,
      'ebitda': instance.ebitda,
      'totalIncome': instance.totalIncome,
      'totalExpenses': instance.totalExpenses,
      'otherIncome': instance.otherIncome,
      'rawMaterials': instance.rawMaterials,
      'powerAndFuel': instance.powerAndFuel,
      'employeeCost': instance.employeeCost,
      'sellingExpenses': instance.sellingExpenses,
      'adminExpenses': instance.adminExpenses,
      'researchAndDevelopment': instance.researchAndDevelopment,
      'depreciation': instance.depreciation,
      'interestExpense': instance.interestExpense,
      'taxExpense': instance.taxExpense,
      'reportDate': const TimestampConverter().toJson(instance.reportDate),
    };

_$AnnualDataImpl _$$AnnualDataImplFromJson(Map<String, dynamic> json) =>
    _$AnnualDataImpl(
      year: json['year'] as String,
      sales: (json['sales'] as num?)?.toDouble(),
      netProfit: (json['netProfit'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      bookValue: (json['bookValue'] as num?)?.toDouble(),
      roe: (json['roe'] as num?)?.toDouble(),
      roce: (json['roce'] as num?)?.toDouble(),
      peRatio: (json['peRatio'] as num?)?.toDouble(),
      pbRatio: (json['pbRatio'] as num?)?.toDouble(),
      dividendPerShare: (json['dividendPerShare'] as num?)?.toDouble(),
      faceValue: (json['faceValue'] as num?)?.toDouble(),
      yearEnd: const TimestampConverter().fromJson(json['yearEnd']),
    );

Map<String, dynamic> _$$AnnualDataImplToJson(_$AnnualDataImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'sales': instance.sales,
      'netProfit': instance.netProfit,
      'eps': instance.eps,
      'bookValue': instance.bookValue,
      'roe': instance.roe,
      'roce': instance.roce,
      'peRatio': instance.peRatio,
      'pbRatio': instance.pbRatio,
      'dividendPerShare': instance.dividendPerShare,
      'faceValue': instance.faceValue,
      'yearEnd': const TimestampConverter().toJson(instance.yearEnd),
    };

_$DividendHistoryImpl _$$DividendHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$DividendHistoryImpl(
      year: json['year'] as String,
      dividendPerShare: (json['dividendPerShare'] as num?)?.toDouble(),
      dividendType: json['dividendType'] as String?,
      exDividendDate:
          const TimestampConverter().fromJson(json['exDividendDate']),
      recordDate: const TimestampConverter().fromJson(json['recordDate']),
      paymentDate: const TimestampConverter().fromJson(json['paymentDate']),
    );

Map<String, dynamic> _$$DividendHistoryImplToJson(
        _$DividendHistoryImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'dividendPerShare': instance.dividendPerShare,
      'dividendType': instance.dividendType,
      'exDividendDate':
          const TimestampConverter().toJson(instance.exDividendDate),
      'recordDate': const TimestampConverter().toJson(instance.recordDate),
      'paymentDate': const TimestampConverter().toJson(instance.paymentDate),
    };

_$ShareholdingPatternImpl _$$ShareholdingPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$ShareholdingPatternImpl(
      quarterly: (json['quarterly'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const <String, Map<String, String>>{},
      promoterHolding: (json['promoterHolding'] as num?)?.toDouble(),
      publicHolding: (json['publicHolding'] as num?)?.toDouble(),
      institutionalHolding: (json['institutionalHolding'] as num?)?.toDouble(),
      foreignInstitutional: (json['foreignInstitutional'] as num?)?.toDouble(),
      domesticInstitutional:
          (json['domesticInstitutional'] as num?)?.toDouble(),
      governmentHolding: (json['governmentHolding'] as num?)?.toDouble(),
      majorShareholders: (json['majorShareholders'] as List<dynamic>?)
              ?.map((e) => MajorShareholder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <MajorShareholder>[],
    );

Map<String, dynamic> _$$ShareholdingPatternImplToJson(
        _$ShareholdingPatternImpl instance) =>
    <String, dynamic>{
      'quarterly': instance.quarterly,
      'promoterHolding': instance.promoterHolding,
      'publicHolding': instance.publicHolding,
      'institutionalHolding': instance.institutionalHolding,
      'foreignInstitutional': instance.foreignInstitutional,
      'domesticInstitutional': instance.domesticInstitutional,
      'governmentHolding': instance.governmentHolding,
      'majorShareholders': instance.majorShareholders,
    };

_$MajorShareholderImpl _$$MajorShareholderImplFromJson(
        Map<String, dynamic> json) =>
    _$MajorShareholderImpl(
      name: json['name'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      shareholderType: json['shareholderType'] as String?,
    );

Map<String, dynamic> _$$MajorShareholderImplToJson(
        _$MajorShareholderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'percentage': instance.percentage,
      'shareholderType': instance.shareholderType,
    };
