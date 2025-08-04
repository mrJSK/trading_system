// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanyDataCollection on Isar {
  IsarCollection<CompanyData> get companyDatas => this.collection();
}

const CompanyDataSchema = CollectionSchema(
  name: r'CompanyData',
  id: 7525521510907764106,
  properties: {
    r'balanceSheet': PropertySchema(
      id: 0,
      name: r'balanceSheet',
      type: IsarType.string,
    ),
    r'bookValue': PropertySchema(
      id: 1,
      name: r'bookValue',
      type: IsarType.double,
    ),
    r'cashFlows': PropertySchema(
      id: 2,
      name: r'cashFlows',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 3,
      name: r'category',
      type: IsarType.string,
    ),
    r'companyDescription': PropertySchema(
      id: 4,
      name: r'companyDescription',
      type: IsarType.string,
    ),
    r'companyId': PropertySchema(
      id: 5,
      name: r'companyId',
      type: IsarType.long,
    ),
    r'companyName': PropertySchema(
      id: 6,
      name: r'companyName',
      type: IsarType.string,
    ),
    r'cons': PropertySchema(
      id: 7,
      name: r'cons',
      type: IsarType.string,
    ),
    r'currentPrice': PropertySchema(
      id: 8,
      name: r'currentPrice',
      type: IsarType.double,
    ),
    r'dividendYield': PropertySchema(
      id: 9,
      name: r'dividendYield',
      type: IsarType.double,
    ),
    r'faceValue': PropertySchema(
      id: 10,
      name: r'faceValue',
      type: IsarType.double,
    ),
    r'hashCode': PropertySchema(
      id: 11,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'highLow': PropertySchema(
      id: 12,
      name: r'highLow',
      type: IsarType.string,
    ),
    r'industry': PropertySchema(
      id: 13,
      name: r'industry',
      type: IsarType.string,
    ),
    r'lastUpdated': PropertySchema(
      id: 14,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'marketCap': PropertySchema(
      id: 15,
      name: r'marketCap',
      type: IsarType.double,
    ),
    r'pb': PropertySchema(
      id: 16,
      name: r'pb',
      type: IsarType.double,
    ),
    r'pe': PropertySchema(
      id: 17,
      name: r'pe',
      type: IsarType.double,
    ),
    r'peerComparison': PropertySchema(
      id: 18,
      name: r'peerComparison',
      type: IsarType.string,
    ),
    r'profitLoss': PropertySchema(
      id: 19,
      name: r'profitLoss',
      type: IsarType.string,
    ),
    r'pros': PropertySchema(
      id: 20,
      name: r'pros',
      type: IsarType.string,
    ),
    r'quarterlyResults': PropertySchema(
      id: 21,
      name: r'quarterlyResults',
      type: IsarType.string,
    ),
    r'ratios': PropertySchema(
      id: 22,
      name: r'ratios',
      type: IsarType.string,
    ),
    r'roce': PropertySchema(
      id: 23,
      name: r'roce',
      type: IsarType.double,
    ),
    r'roe': PropertySchema(
      id: 24,
      name: r'roe',
      type: IsarType.double,
    ),
    r'sector': PropertySchema(
      id: 25,
      name: r'sector',
      type: IsarType.string,
    ),
    r'subIndustry': PropertySchema(
      id: 26,
      name: r'subIndustry',
      type: IsarType.string,
    )
  },
  estimateSize: _companyDataEstimateSize,
  serialize: _companyDataSerialize,
  deserialize: _companyDataDeserialize,
  deserializeProp: _companyDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _companyDataGetId,
  getLinks: _companyDataGetLinks,
  attach: _companyDataAttach,
  version: '3.1.0+1',
);

int _companyDataEstimateSize(
  CompanyData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.balanceSheet;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cashFlows;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.companyDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.companyName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.cons;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.highLow;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.industry;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.peerComparison;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.profitLoss;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pros;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.quarterlyResults;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ratios;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sector;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subIndustry;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _companyDataSerialize(
  CompanyData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.balanceSheet);
  writer.writeDouble(offsets[1], object.bookValue);
  writer.writeString(offsets[2], object.cashFlows);
  writer.writeString(offsets[3], object.category);
  writer.writeString(offsets[4], object.companyDescription);
  writer.writeLong(offsets[5], object.companyId);
  writer.writeString(offsets[6], object.companyName);
  writer.writeString(offsets[7], object.cons);
  writer.writeDouble(offsets[8], object.currentPrice);
  writer.writeDouble(offsets[9], object.dividendYield);
  writer.writeDouble(offsets[10], object.faceValue);
  writer.writeLong(offsets[11], object.hashCode);
  writer.writeString(offsets[12], object.highLow);
  writer.writeString(offsets[13], object.industry);
  writer.writeDateTime(offsets[14], object.lastUpdated);
  writer.writeDouble(offsets[15], object.marketCap);
  writer.writeDouble(offsets[16], object.pb);
  writer.writeDouble(offsets[17], object.pe);
  writer.writeString(offsets[18], object.peerComparison);
  writer.writeString(offsets[19], object.profitLoss);
  writer.writeString(offsets[20], object.pros);
  writer.writeString(offsets[21], object.quarterlyResults);
  writer.writeString(offsets[22], object.ratios);
  writer.writeDouble(offsets[23], object.roce);
  writer.writeDouble(offsets[24], object.roe);
  writer.writeString(offsets[25], object.sector);
  writer.writeString(offsets[26], object.subIndustry);
}

CompanyData _companyDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CompanyData();
  object.balanceSheet = reader.readStringOrNull(offsets[0]);
  object.bookValue = reader.readDoubleOrNull(offsets[1]);
  object.cashFlows = reader.readStringOrNull(offsets[2]);
  object.category = reader.readStringOrNull(offsets[3]);
  object.companyDescription = reader.readStringOrNull(offsets[4]);
  object.companyId = reader.readLongOrNull(offsets[5]);
  object.companyName = reader.readStringOrNull(offsets[6]);
  object.cons = reader.readStringOrNull(offsets[7]);
  object.currentPrice = reader.readDoubleOrNull(offsets[8]);
  object.dividendYield = reader.readDoubleOrNull(offsets[9]);
  object.faceValue = reader.readDoubleOrNull(offsets[10]);
  object.highLow = reader.readStringOrNull(offsets[12]);
  object.id = id;
  object.industry = reader.readStringOrNull(offsets[13]);
  object.lastUpdated = reader.readDateTimeOrNull(offsets[14]);
  object.marketCap = reader.readDoubleOrNull(offsets[15]);
  object.pb = reader.readDoubleOrNull(offsets[16]);
  object.pe = reader.readDoubleOrNull(offsets[17]);
  object.peerComparison = reader.readStringOrNull(offsets[18]);
  object.profitLoss = reader.readStringOrNull(offsets[19]);
  object.pros = reader.readStringOrNull(offsets[20]);
  object.quarterlyResults = reader.readStringOrNull(offsets[21]);
  object.ratios = reader.readStringOrNull(offsets[22]);
  object.roce = reader.readDoubleOrNull(offsets[23]);
  object.roe = reader.readDoubleOrNull(offsets[24]);
  object.sector = reader.readStringOrNull(offsets[25]);
  object.subIndustry = reader.readStringOrNull(offsets[26]);
  return object;
}

P _companyDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _companyDataGetId(CompanyData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companyDataGetLinks(CompanyData object) {
  return [];
}

void _companyDataAttach(
    IsarCollection<dynamic> col, Id id, CompanyData object) {
  object.id = id;
}

extension CompanyDataQueryWhereSort
    on QueryBuilder<CompanyData, CompanyData, QWhere> {
  QueryBuilder<CompanyData, CompanyData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompanyDataQueryWhere
    on QueryBuilder<CompanyData, CompanyData, QWhereClause> {
  QueryBuilder<CompanyData, CompanyData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CompanyDataQueryFilter
    on QueryBuilder<CompanyData, CompanyData, QFilterCondition> {
  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'balanceSheet',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'balanceSheet',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'balanceSheet',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'balanceSheet',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'balanceSheet',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'balanceSheet',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      balanceSheetIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'balanceSheet',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookValue',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookValue',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      bookValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cashFlows',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cashFlows',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cashFlows',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cashFlows',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cashFlows',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cashFlows',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      cashFlowsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cashFlows',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyDescription',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyDescription',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyName',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyName',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      companyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cons',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      consIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cons',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cons',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cons',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> consIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cons',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      consIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cons',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentPrice',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentPrice',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      currentPriceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dividendYield',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dividendYield',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dividendYield',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      dividendYieldBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dividendYield',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'faceValue',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'faceValue',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'faceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'faceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'faceValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      faceValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'faceValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'highLow',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'highLow',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'highLow',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'highLow',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> highLowMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'highLow',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'highLow',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      highLowIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'highLow',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'industry',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'industry',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> industryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> industryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'industry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'industry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> industryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'industry',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'industry',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      industryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'industry',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      lastUpdatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'marketCap',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'marketCap',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marketCap',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      marketCapBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marketCap',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pb',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pb',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pb',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> pbBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pe',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pe',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> peBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peerComparison',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peerComparison',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peerComparison',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peerComparison',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peerComparison',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peerComparison',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      peerComparisonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peerComparison',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'profitLoss',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'profitLoss',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'profitLoss',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'profitLoss',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'profitLoss',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'profitLoss',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      profitLossIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'profitLoss',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pros',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      prosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pros',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pros',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pros',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> prosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pros',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      prosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pros',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quarterlyResults',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quarterlyResults',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quarterlyResults',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quarterlyResults',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quarterlyResults',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quarterlyResults',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      quarterlyResultsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quarterlyResults',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ratios',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      ratiosIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ratios',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      ratiosGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratios',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      ratiosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ratios',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> ratiosMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ratios',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      ratiosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratios',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      ratiosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ratios',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roce',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      roceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roce',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roce',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roce',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roce',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roce',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'roe',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'roe',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'roe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'roe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'roe',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> roeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'roe',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sector',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      sectorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sector',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      sectorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sector',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      sectorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sector',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition> sectorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sector',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      sectorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sector',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      sectorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sector',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subIndustry',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subIndustry',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subIndustry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subIndustry',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subIndustry',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subIndustry',
        value: '',
      ));
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterFilterCondition>
      subIndustryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subIndustry',
        value: '',
      ));
    });
  }
}

extension CompanyDataQueryObject
    on QueryBuilder<CompanyData, CompanyData, QFilterCondition> {}

extension CompanyDataQueryLinks
    on QueryBuilder<CompanyData, CompanyData, QFilterCondition> {}

extension CompanyDataQuerySortBy
    on QueryBuilder<CompanyData, CompanyData, QSortBy> {
  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByBalanceSheet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceSheet', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByBalanceSheetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceSheet', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByBookValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookValue', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByBookValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookValue', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCashFlows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashFlows', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCashFlowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashFlows', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByCompanyDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyDescription', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByCompanyDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyDescription', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cons', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByConsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cons', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByCurrentPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dividendYield', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dividendYield', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByFaceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceValue', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByFaceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceValue', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByHighLow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highLow', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByHighLowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highLow', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByIndustry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industry', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByIndustryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industry', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pb', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pb', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pe', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pe', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPeerComparison() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerComparison', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByPeerComparisonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerComparison', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByProfitLoss() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profitLoss', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByProfitLossDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profitLoss', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByPros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pros', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByProsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pros', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByQuarterlyResults() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quarterlyResults', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      sortByQuarterlyResultsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quarterlyResults', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRatios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratios', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRatiosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratios', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRoce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roce', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRoceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roce', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRoe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roe', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortByRoeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roe', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortBySector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortBySectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortBySubIndustry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subIndustry', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> sortBySubIndustryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subIndustry', Sort.desc);
    });
  }
}

extension CompanyDataQuerySortThenBy
    on QueryBuilder<CompanyData, CompanyData, QSortThenBy> {
  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByBalanceSheet() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceSheet', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByBalanceSheetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'balanceSheet', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByBookValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookValue', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByBookValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookValue', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCashFlows() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashFlows', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCashFlowsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cashFlows', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByCompanyDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyDescription', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByCompanyDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyDescription', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCons() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cons', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByConsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cons', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByCurrentPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPrice', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dividendYield', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByDividendYieldDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dividendYield', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByFaceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceValue', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByFaceValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'faceValue', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByHighLow() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highLow', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByHighLowDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highLow', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByIndustry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industry', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByIndustryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'industry', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByMarketCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marketCap', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pb', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pb', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pe', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pe', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPeerComparison() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerComparison', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByPeerComparisonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peerComparison', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByProfitLoss() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profitLoss', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByProfitLossDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'profitLoss', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByPros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pros', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByProsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pros', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByQuarterlyResults() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quarterlyResults', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy>
      thenByQuarterlyResultsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quarterlyResults', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRatios() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratios', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRatiosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratios', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRoce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roce', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRoceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roce', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRoe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roe', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenByRoeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'roe', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenBySector() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenBySectorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sector', Sort.desc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenBySubIndustry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subIndustry', Sort.asc);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QAfterSortBy> thenBySubIndustryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subIndustry', Sort.desc);
    });
  }
}

extension CompanyDataQueryWhereDistinct
    on QueryBuilder<CompanyData, CompanyData, QDistinct> {
  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByBalanceSheet(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'balanceSheet', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByBookValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookValue');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCashFlows(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cashFlows', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct>
      distinctByCompanyDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCompanyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCons(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cons', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByCurrentPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentPrice');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByDividendYield() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dividendYield');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByFaceValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'faceValue');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByHighLow(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'highLow', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByIndustry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'industry', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByMarketCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marketCap');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByPb() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pb');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByPe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pe');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByPeerComparison(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peerComparison',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByProfitLoss(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'profitLoss', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByPros(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pros', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByQuarterlyResults(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quarterlyResults',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByRatios(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratios', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByRoce() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roce');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctByRoe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'roe');
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctBySector(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sector', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CompanyData, CompanyData, QDistinct> distinctBySubIndustry(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subIndustry', caseSensitive: caseSensitive);
    });
  }
}

extension CompanyDataQueryProperty
    on QueryBuilder<CompanyData, CompanyData, QQueryProperty> {
  QueryBuilder<CompanyData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> balanceSheetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'balanceSheet');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> bookValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookValue');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> cashFlowsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cashFlows');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations>
      companyDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyDescription');
    });
  }

  QueryBuilder<CompanyData, int?, QQueryOperations> companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> companyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyName');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> consProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cons');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> currentPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentPrice');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> dividendYieldProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dividendYield');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> faceValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'faceValue');
    });
  }

  QueryBuilder<CompanyData, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> highLowProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'highLow');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> industryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'industry');
    });
  }

  QueryBuilder<CompanyData, DateTime?, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> marketCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marketCap');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> pbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pb');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> peProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pe');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations>
      peerComparisonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peerComparison');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> profitLossProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'profitLoss');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> prosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pros');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations>
      quarterlyResultsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quarterlyResults');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> ratiosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratios');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> roceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roce');
    });
  }

  QueryBuilder<CompanyData, double?, QQueryOperations> roeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roe');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> sectorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sector');
    });
  }

  QueryBuilder<CompanyData, String?, QQueryOperations> subIndustryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subIndustry');
    });
  }
}
