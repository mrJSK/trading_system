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
      workingCapitalDays: (json['workingCapitalDays'] as num?)?.toDouble(),
      debtorDays: (json['debtorDays'] as num?)?.toDouble(),
      inventoryDays: (json['inventoryDays'] as num?)?.toDouble(),
      cashConversionCycle: (json['cashConversionCycle'] as num?)?.toDouble(),
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
      rawFinancialTables: const RawFinancialTablesConverter()
          .fromJson(json['rawFinancialTables']),
      companyKeyPoints:
          const CompanyKeyPointsConverter().fromJson(json['companyKeyPoints']),
      calculatedMetrics: const CalculatedMetricsConverter()
          .fromJson(json['calculatedMetrics']),
      businessOverview: json['businessOverview'] as String? ?? '',
      sector: json['sector'] as String?,
      industry: json['industry'] as String?,
      industryClassification: (json['industryClassification'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recentPerformance:
          json['recentPerformance'] as Map<String, dynamic>? ?? const {},
      keyMilestones: (json['keyMilestones'] as List<dynamic>?)
              ?.map((e) => KeyMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      investmentHighlights: (json['investmentHighlights'] as List<dynamic>?)
              ?.map((e) =>
                  InvestmentHighlight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      financialSummary: (json['financialSummary'] as List<dynamic>?)
              ?.map((e) => FinancialSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      qualityScore: (json['qualityScore'] as num?)?.toInt() ?? 3,
      overallQualityGrade: json['overallQualityGrade'] as String? ?? 'C',
      workingCapitalEfficiency:
          json['workingCapitalEfficiency'] as String? ?? 'Unknown',
      cashCycleEfficiency: json['cashCycleEfficiency'] as String? ?? 'Unknown',
      liquidityStatus: json['liquidityStatus'] as String? ?? 'Unknown',
      debtStatus: json['debtStatus'] as String? ?? 'Unknown',
      riskLevel: json['riskLevel'] as String? ?? 'Medium',
      piotroskiScore: (json['piotroskiScore'] as num?)?.toDouble(),
      altmanZScore: (json['altmanZScore'] as num?)?.toDouble(),
      qualityGrade: json['qualityGrade'] as String?,
      creditRating: json['creditRating'] as String?,
      grahamNumber: (json['grahamNumber'] as num?)?.toDouble(),
      roic: (json['roic'] as num?)?.toDouble(),
      fcfYield: (json['fcfYield'] as num?)?.toDouble(),
      debtServiceCoverage: (json['debtServiceCoverage'] as num?)?.toDouble(),
      comprehensiveScore: (json['comprehensiveScore'] as num?)?.toDouble(),
      investmentRecommendation: json['investmentRecommendation'] as String?,
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
      'workingCapitalDays': instance.workingCapitalDays,
      'debtorDays': instance.debtorDays,
      'inventoryDays': instance.inventoryDays,
      'cashConversionCycle': instance.cashConversionCycle,
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
      'rawFinancialTables': const RawFinancialTablesConverter()
          .toJson(instance.rawFinancialTables),
      'companyKeyPoints':
          const CompanyKeyPointsConverter().toJson(instance.companyKeyPoints),
      'calculatedMetrics':
          const CalculatedMetricsConverter().toJson(instance.calculatedMetrics),
      'businessOverview': instance.businessOverview,
      'sector': instance.sector,
      'industry': instance.industry,
      'industryClassification': instance.industryClassification,
      'recentPerformance': instance.recentPerformance,
      'keyMilestones': instance.keyMilestones,
      'investmentHighlights': instance.investmentHighlights,
      'financialSummary': instance.financialSummary,
      'qualityScore': instance.qualityScore,
      'overallQualityGrade': instance.overallQualityGrade,
      'workingCapitalEfficiency': instance.workingCapitalEfficiency,
      'cashCycleEfficiency': instance.cashCycleEfficiency,
      'liquidityStatus': instance.liquidityStatus,
      'debtStatus': instance.debtStatus,
      'riskLevel': instance.riskLevel,
      'piotroskiScore': instance.piotroskiScore,
      'altmanZScore': instance.altmanZScore,
      'qualityGrade': instance.qualityGrade,
      'creditRating': instance.creditRating,
      'grahamNumber': instance.grahamNumber,
      'roic': instance.roic,
      'fcfYield': instance.fcfYield,
      'debtServiceCoverage': instance.debtServiceCoverage,
      'comprehensiveScore': instance.comprehensiveScore,
      'investmentRecommendation': instance.investmentRecommendation,
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

_$RawFinancialTablesImpl _$$RawFinancialTablesImplFromJson(
        Map<String, dynamic> json) =>
    _$RawFinancialTablesImpl(
      quarterlyResults:
          json['quarterlyResults'] as Map<String, dynamic>? ?? const {},
      profitLossStatement:
          json['profitLossStatement'] as Map<String, dynamic>? ?? const {},
      balanceSheet: json['balanceSheet'] as Map<String, dynamic>? ?? const {},
      cashFlowStatement:
          json['cashFlowStatement'] as Map<String, dynamic>? ?? const {},
      ratiosTable: json['ratiosTable'] as Map<String, dynamic>? ?? const {},
      shareholdingTable:
          json['shareholdingTable'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$RawFinancialTablesImplToJson(
        _$RawFinancialTablesImpl instance) =>
    <String, dynamic>{
      'quarterlyResults': instance.quarterlyResults,
      'profitLossStatement': instance.profitLossStatement,
      'balanceSheet': instance.balanceSheet,
      'cashFlowStatement': instance.cashFlowStatement,
      'ratiosTable': instance.ratiosTable,
      'shareholdingTable': instance.shareholdingTable,
    };

_$CompanyKeyPointsImpl _$$CompanyKeyPointsImplFromJson(
        Map<String, dynamic> json) =>
    _$CompanyKeyPointsImpl(
      businessHighlights: (json['businessHighlights'] as List<dynamic>?)
              ?.map(
                  (e) => BusinessHighlight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      financialStrengths: (json['financialStrengths'] as List<dynamic>?)
              ?.map(
                  (e) => FinancialStrength.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      riskFactors: (json['riskFactors'] as List<dynamic>?)
              ?.map((e) => RiskFactor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      competitiveAdvantages: (json['competitiveAdvantages'] as List<dynamic>?)
              ?.map((e) =>
                  CompetitiveAdvantage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentDevelopments: (json['recentDevelopments'] as List<dynamic>?)
              ?.map(
                  (e) => RecentDevelopment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      managementInsights: (json['managementInsights'] as List<dynamic>?)
              ?.map(
                  (e) => ManagementInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CompanyKeyPointsImplToJson(
        _$CompanyKeyPointsImpl instance) =>
    <String, dynamic>{
      'businessHighlights': instance.businessHighlights,
      'financialStrengths': instance.financialStrengths,
      'riskFactors': instance.riskFactors,
      'competitiveAdvantages': instance.competitiveAdvantages,
      'recentDevelopments': instance.recentDevelopments,
      'managementInsights': instance.managementInsights,
    };

_$BusinessHighlightImpl _$$BusinessHighlightImplFromJson(
        Map<String, dynamic> json) =>
    _$BusinessHighlightImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
    );

Map<String, dynamic> _$$BusinessHighlightImplToJson(
        _$BusinessHighlightImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
    };

_$FinancialStrengthImpl _$$FinancialStrengthImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialStrengthImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
      value: (json['value'] as num?)?.toDouble(),
      trend: json['trend'] as String?,
    );

Map<String, dynamic> _$$FinancialStrengthImplToJson(
        _$FinancialStrengthImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'value': instance.value,
      'trend': instance.trend,
    };

_$RiskFactorImpl _$$RiskFactorImplFromJson(Map<String, dynamic> json) =>
    _$RiskFactorImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
      severity: json['severity'] as String,
    );

Map<String, dynamic> _$$RiskFactorImplToJson(_$RiskFactorImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'severity': instance.severity,
    };

_$CompetitiveAdvantageImpl _$$CompetitiveAdvantageImplFromJson(
        Map<String, dynamic> json) =>
    _$CompetitiveAdvantageImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
      sustainability: json['sustainability'] as String?,
    );

Map<String, dynamic> _$$CompetitiveAdvantageImplToJson(
        _$CompetitiveAdvantageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'sustainability': instance.sustainability,
    };

_$RecentDevelopmentImpl _$$RecentDevelopmentImplFromJson(
        Map<String, dynamic> json) =>
    _$RecentDevelopmentImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$RecentDevelopmentImplToJson(
        _$RecentDevelopmentImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'date': instance.date?.toIso8601String(),
    };

_$ManagementInsightImpl _$$ManagementInsightImplFromJson(
        Map<String, dynamic> json) =>
    _$ManagementInsightImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
    );

Map<String, dynamic> _$$ManagementInsightImplToJson(
        _$ManagementInsightImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
    };

_$CalculatedMetricsImpl _$$CalculatedMetricsImplFromJson(
        Map<String, dynamic> json) =>
    _$CalculatedMetricsImpl(
      piotroskiScore: (json['piotroskiScore'] as num?)?.toDouble(),
      altmanZScore: (json['altmanZScore'] as num?)?.toDouble(),
      grahamNumber: (json['grahamNumber'] as num?)?.toDouble(),
      pegRatio: (json['pegRatio'] as num?)?.toDouble(),
      roic: (json['roic'] as num?)?.toDouble(),
      fcfYield: (json['fcfYield'] as num?)?.toDouble(),
      comprehensiveScore: (json['comprehensiveScore'] as num?)?.toDouble(),
      riskAssessment: json['riskAssessment'] as String?,
      investmentGrade: json['investmentGrade'] as String?,
      investmentRecommendation: json['investmentRecommendation'] as String?,
      safetyMargin: (json['safetyMargin'] as num?)?.toDouble(),
      debtServiceCoverage: (json['debtServiceCoverage'] as num?)?.toDouble(),
      workingCapitalTurnover:
          (json['workingCapitalTurnover'] as num?)?.toDouble(),
      returnOnAssets: (json['returnOnAssets'] as num?)?.toDouble(),
      returnOnCapital: (json['returnOnCapital'] as num?)?.toDouble(),
      evToEbitda: (json['evToEbitda'] as num?)?.toDouble(),
      priceToFreeCashFlow: (json['priceToFreeCashFlow'] as num?)?.toDouble(),
      enterpriseValueToSales:
          (json['enterpriseValueToSales'] as num?)?.toDouble(),
      sectorComparison:
          (json['sectorComparison'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      qualityMetrics: (json['qualityMetrics'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      strengthFactors: (json['strengthFactors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      weaknessFactors: (json['weaknessFactors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      valuationMetrics: json['valuationMetrics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CalculatedMetricsImplToJson(
        _$CalculatedMetricsImpl instance) =>
    <String, dynamic>{
      'piotroskiScore': instance.piotroskiScore,
      'altmanZScore': instance.altmanZScore,
      'grahamNumber': instance.grahamNumber,
      'pegRatio': instance.pegRatio,
      'roic': instance.roic,
      'fcfYield': instance.fcfYield,
      'comprehensiveScore': instance.comprehensiveScore,
      'riskAssessment': instance.riskAssessment,
      'investmentGrade': instance.investmentGrade,
      'investmentRecommendation': instance.investmentRecommendation,
      'safetyMargin': instance.safetyMargin,
      'debtServiceCoverage': instance.debtServiceCoverage,
      'workingCapitalTurnover': instance.workingCapitalTurnover,
      'returnOnAssets': instance.returnOnAssets,
      'returnOnCapital': instance.returnOnCapital,
      'evToEbitda': instance.evToEbitda,
      'priceToFreeCashFlow': instance.priceToFreeCashFlow,
      'enterpriseValueToSales': instance.enterpriseValueToSales,
      'sectorComparison': instance.sectorComparison,
      'qualityMetrics': instance.qualityMetrics,
      'strengthFactors': instance.strengthFactors,
      'weaknessFactors': instance.weaknessFactors,
      'valuationMetrics': instance.valuationMetrics,
    };

_$KeyMilestoneImpl _$$KeyMilestoneImplFromJson(Map<String, dynamic> json) =>
    _$KeyMilestoneImpl(
      category: json['category'] as String,
      description: json['description'] as String,
      relevance: json['relevance'] as String? ?? 'medium',
      year: json['year'] as String?,
      date: const TimestampConverter().fromJson(json['date']),
    );

Map<String, dynamic> _$$KeyMilestoneImplToJson(_$KeyMilestoneImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'description': instance.description,
      'relevance': instance.relevance,
      'year': instance.year,
      'date': const TimestampConverter().toJson(instance.date),
    };

_$InvestmentHighlightImpl _$$InvestmentHighlightImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestmentHighlightImpl(
      type: json['type'] as String,
      description: json['description'] as String,
      impact: json['impact'] as String,
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$InvestmentHighlightImplToJson(
        _$InvestmentHighlightImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'value': instance.value,
      'unit': instance.unit,
    };

_$FinancialSummaryImpl _$$FinancialSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialSummaryImpl(
      metric: json['metric'] as String,
      value: json['value'] as String,
      unit: json['unit'] as String?,
      trend: json['trend'] as String?,
    );

Map<String, dynamic> _$$FinancialSummaryImplToJson(
        _$FinancialSummaryImpl instance) =>
    <String, dynamic>{
      'metric': instance.metric,
      'value': instance.value,
      'unit': instance.unit,
      'trend': instance.trend,
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
      profitMargin: (json['profitMargin'] as num?)?.toDouble(),
      ebitdaMargin: (json['ebitdaMargin'] as num?)?.toDouble(),
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
      'profitMargin': instance.profitMargin,
      'ebitdaMargin': instance.ebitdaMargin,
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
      operatingProfit: (json['operatingProfit'] as num?)?.toDouble(),
      ebitda: (json['ebitda'] as num?)?.toDouble(),
      grossProfit: (json['grossProfit'] as num?)?.toDouble(),
      totalAssets: (json['totalAssets'] as num?)?.toDouble(),
      totalLiabilities: (json['totalLiabilities'] as num?)?.toDouble(),
      shareholdersEquity: (json['shareholdersEquity'] as num?)?.toDouble(),
      totalDebt: (json['totalDebt'] as num?)?.toDouble(),
      workingCapital: (json['workingCapital'] as num?)?.toDouble(),
      operatingCashFlow: (json['operatingCashFlow'] as num?)?.toDouble(),
      investingCashFlow: (json['investingCashFlow'] as num?)?.toDouble(),
      financingCashFlow: (json['financingCashFlow'] as num?)?.toDouble(),
      freeCashFlow: (json['freeCashFlow'] as num?)?.toDouble(),
      currentRatio: (json['currentRatio'] as num?)?.toDouble(),
      quickRatio: (json['quickRatio'] as num?)?.toDouble(),
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
      profitMargin: (json['profitMargin'] as num?)?.toDouble(),
      ebitdaMargin: (json['ebitdaMargin'] as num?)?.toDouble(),
      assetTurnover: (json['assetTurnover'] as num?)?.toDouble(),
      inventoryTurnover: (json['inventoryTurnover'] as num?)?.toDouble(),
      interestCoverage: (json['interestCoverage'] as num?)?.toDouble(),
      interestExpense: (json['interestExpense'] as num?)?.toDouble(),
      taxExpense: (json['taxExpense'] as num?)?.toDouble(),
      depreciation: (json['depreciation'] as num?)?.toDouble(),
      amortization: (json['amortization'] as num?)?.toDouble(),
      capitalExpenditures: (json['capitalExpenditures'] as num?)?.toDouble(),
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
      'operatingProfit': instance.operatingProfit,
      'ebitda': instance.ebitda,
      'grossProfit': instance.grossProfit,
      'totalAssets': instance.totalAssets,
      'totalLiabilities': instance.totalLiabilities,
      'shareholdersEquity': instance.shareholdersEquity,
      'totalDebt': instance.totalDebt,
      'workingCapital': instance.workingCapital,
      'operatingCashFlow': instance.operatingCashFlow,
      'investingCashFlow': instance.investingCashFlow,
      'financingCashFlow': instance.financingCashFlow,
      'freeCashFlow': instance.freeCashFlow,
      'currentRatio': instance.currentRatio,
      'quickRatio': instance.quickRatio,
      'debtToEquity': instance.debtToEquity,
      'profitMargin': instance.profitMargin,
      'ebitdaMargin': instance.ebitdaMargin,
      'assetTurnover': instance.assetTurnover,
      'inventoryTurnover': instance.inventoryTurnover,
      'interestCoverage': instance.interestCoverage,
      'interestExpense': instance.interestExpense,
      'taxExpense': instance.taxExpense,
      'depreciation': instance.depreciation,
      'amortization': instance.amortization,
      'capitalExpenditures': instance.capitalExpenditures,
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
